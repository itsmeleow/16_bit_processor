module reg_file (
    input  wire        clk,
    input  wire [3:0]  reg_src, // RS [7:4]
    input  wire [3:0]  reg_dest, // RT/RD [11:8]
    input  wire [15:0] write_data,
    input  wire        reg_write, // 1 = write, 0 = read from the CU

    output wire [15:0] read_data1,
    output wire [15:0] read_data2,
    output wire [15:0] display_data
);

    reg [15:0] registers [0:15]; // Reg file - 16 registers of 16 bit wide, $r0-$r15

    // clear all registers to 0 on run time, except for r0 which is always 0. r7 is used to display values on the 7-segment display.
    integer i;
    initial begin
        for (i = 0; i < 16; i = i + 1)
            registers[i] = 16'h0000;
    end

    always @(posedge clk) begin
        if (reg_write) begin
            registers[reg_dest] <= write_data;
        end
    end

    assign read_data1 = registers[reg_src];
    assign read_data2 = registers[reg_dest];
    assign display_data = registers[7]; // write to register r7 to display a value on the 7-segment display.
endmodule
