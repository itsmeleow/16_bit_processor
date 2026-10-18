module pc_counter(
    input wire [15:0] pc_in,
    input wire clk,
    output reg [15:0] pc_out
);

    intial begin
        pc_out = 16'h0000; //start PC at mem location 0
    end

    always @(posedge clk) begin
        pc_out <= pc_in;
    end



endmodule