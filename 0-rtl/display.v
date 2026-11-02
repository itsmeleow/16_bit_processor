/* 
 * Basys3 FPGA 7-segment display module (active-low)
 * 
 * Supports displaying hexadecimal digits (0-9) on the four digit 7-segment display
 */ 

module display (
    input  wire        clk,
    input  wire [15:0] data_in,
    output reg  [6:0]  seg,
    output reg  [3:0]  an
);

    reg [19:0] refresh_counter = 0;
    
    // the basys 3 has a 100MHz clock, so we can use a 20-bit counter to create a refresh rate of ~1ms for the display
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
    end

    // only check for the top 2 bits of the refresh counter to determine which digit to display
    wire [1:0] active_digit = refresh_counter[19:18];

    // current hex digit to display (4 bits) from the 16-bit input data_in
    reg [3:0] current_data;

    // selects the digit slot and its corresponding data chunk
    always @(*) begin
        // default values (active-low)
        an = 4'b1111;
        current_data = 4'h0;

        // left -> right: AN3, AN2, AN1, AN0
        case (active_digit)
            2'b00: begin
                // enable leftmost digit (AN3)
                an = 4'b0111;                   
                current_data = data_in[15:12]; 
            end
            2'b01: begin
                // enable second digit (AN2)
                an = 4'b1011;                  
                current_data = data_in[11:8]; 
            end
            2'b10: begin
                // enable third digit (AN1)
                an = 4'b1101;                 
                current_data = data_in[7:4];
            end
            2'b11: begin
                // enable rightmost digit (AN0)
                an = 4'b1110;                  
                current_data = data_in[3:0];
            end
        endcase
    end

    always @(*) begin
        case (current_data)
            4'h0: seg = 7'b1000000; // Hex '0'
            4'h1: seg = 7'b1111001; // Hex '1'
            4'h2: seg = 7'b0100100; // Hex '2'
            4'h3: seg = 7'b0110000; // Hex '3'
            4'h4: seg = 7'b0011001; // Hex '4'
            4'h5: seg = 7'b0010010; // Hex '5'
            4'h6: seg = 7'b0000010; // Hex '6'
            4'h7: seg = 7'b1111000; // Hex '7'
            4'h8: seg = 7'b0000000; // Hex '8'
            4'h9: seg = 7'b0010000; // Hex '9'
            default: seg = 7'b1111111; // default: turn off all segments
        endcase
    end
endmodule
