module pc_counter(
    input  wire        clk,
    input  wire [15:0] pc_in,
    output reg  [15:0] pc_out
);

    initial begin
        pc_out = 16'h0000; //start PC at mem location 0
    end

    always @(posedge clk) begin
        pc_out <= pc_in;
    end
endmodule
