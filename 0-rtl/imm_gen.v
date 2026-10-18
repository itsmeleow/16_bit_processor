module imm_gen (
    input  wire [15:0] instruction,
    output reg  [15:0] imm_value
);

    always @(*) begin
        // set the default value first
        imm_value = 16'b0;

        case (instruction[15:12])
            4'b0001: imm_value = {12'b0, instruction[11:0]}; // I-type
            4'b0010: imm_value = {8'b0, instruction[7:0]};   // J-type
            default: imm_value = 16'b0;                      // default case for unsupported instructions
        endcase
    end
endmodule
