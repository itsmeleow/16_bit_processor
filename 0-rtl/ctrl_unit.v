module ctrl_unit (
    input wire [3:0]  opcode,
    input wire [3:0]  funct,
    output reg        reg_write,
    output reg        mem_read,
    output reg        mem_write,
    output reg        alu_src,
    output reg        mem_to_reg,
    output reg        branch,
    output reg        jump,
    output reg [3:0]  alu_op
);

    localparam OPCODE_R_TYPE       = 4'b0000;
    localparam OPCODE_I_TYPE_LOAD  = 4'b0001;
    localparam OPCODE_I_TYPE_STORE = 4'b0010;
    localparam OPCODE_I_TYPE_ALU   = 4'b0011;
    localparam OPCODE_I_TYPE_BEQ   = 4'b0100;
    localparam OPCODE_I_TYPE_BNE   = 4'b0101;
    localparam OPCODE_J_TYPE       = 4'b0110;

    // shown for readability, function codes map to the same ALU opcodes
    localparam [3:0] ALU_ADD = 4'b0000;
    localparam [3:0] ALU_SUB = 4'b0001;
    localparam [3:0] ALU_SLL = 4'b0010;
    localparam [3:0] ALU_AND = 4'b0011;


    always @(*) begin
        // assign default values to the control signals
        reg_write = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        branch = 1'b0;
        jump = 1'b0;
        alu_op = ALU_ADD;

        case (opcode)
            // R-type
            OPCODE_R_TYPE: begin
                reg_write = 1'b1;
                alu_op = funct; // Use function code for ALU operation
            end

            // I-type (Load)
            OPCODE_I_TYPE_LOAD: begin
                reg_write = 1'b1;
                mem_read = 1'b1;
                alu_src = 1'b1; // Immediate value as src_b ALU operand
                mem_to_reg = 1'b1;
            end

            // I-type (Store)
            OPCODE_I_TYPE_STORE: begin
                mem_write = 1'b1;
                alu_src = 1'b1;
            end

            // I-type (ALU)
            OPCODE_I_TYPE_ALU: begin
                reg_write = 1'b1;
                mem_read = 1'b1;
                alu_src = 1'b1;
                mem_to_reg = 1'b1;
                alu_op = ALU_ADD;
            end

            // I-type (BEQ)
            OPCODE_I_TYPE_BEQ: begin
                branch = 1'b1;
                alu_op = ALU_SUB;
            end

            // I-type (BNE)
            OPCODE_I_TYPE_BNE: begin
                branch = 1'b1;
                alu_op = ALU_SUB;
            end

            // J-type
            OPCODE_J_TYPE: begin
                jump = 1'b1;
            end

            default: begin
                // keep default control signals, asserted to 0 and alu_op to ALU_ADD
            end
        endcase
    end

endmodule
