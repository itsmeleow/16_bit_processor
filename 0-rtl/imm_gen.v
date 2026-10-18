module imm_gen (
    input  wire [15:0] instruction,
    output reg  [15:0] imm_value
);
    localparam OPCODE_I_TYPE_LOAD  = 4'b0001;
    localparam OPCODE_I_TYPE_STORE = 4'b0010;
    localparam OPCODE_I_TYPE_ALU   = 4'b0011;
    localparam OPCODE_I_TYPE_BEQ   = 4'b0100;
    localparam OPCODE_I_TYPE_BNE   = 4'b0101;
    localparam OPCODE_J_TYPE       = 4'b0110;

    assign opcode = instruction[15:12];  // Extract the opcode from the instruction

    always @(*) begin
        case (opcode)
            // I-type
            OPCODE_I_TYPE_LOAD, 
            OPCODE_I_TYPE_STORE, 
            OPCODE_I_TYPE_ALU,
            OPCODE_I_TYPE_BEQ, 
            OPCODE_I_TYPE_BNE: 
                imm_value = {12{instruction[3]}, instruction[3:0]};

            // J-type
            OPCODE_J_TYPE: 
                imm_value = {4{instruction[11]}, instruction[11:0]};

            default: 
                imm_value <= 16'b0; // default case for instructions without immediate values
        endcase
    end
endmodule
