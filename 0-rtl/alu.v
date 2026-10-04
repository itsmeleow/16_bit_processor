module alu (
    input  wire [15:0] src_a,
    input  wire [15:0] src_b,
    input  wire [3:0]  alu_opcode,
    output reg  [15:0] result
);

    // just initializing ALU OP codes for readability
    localparam [3:0] ALU_ADD = 4'b0000;
    localparam [3:0] ALU_SUB = 4'b0001;
    localparam [3:0] ALU_SLL = 4'b0010;
    localparam [3:0] ALU_AND = 4'b0011;

    always @(*) begin
        result = 16'b0;   // set the default value first

        case (alu_opcode)
            ALU_ADD: result = src_a + src_b;
            ALU_SUB: result = src_a - src_b;
            ALU_SLL: result = src_a << src_b[3:0];
            ALU_AND: result = src_a & src_b;

            // more ALU operations added when needed here (12 more operations allowed)
            default: result = 16'b0;
        endcase
    end

endmodule