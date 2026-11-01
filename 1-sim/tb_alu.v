module tb_alu;

    reg [15:0] src_a;
    reg [15:0] src_b;
    reg [3:0]  alu_opcode;
    wire [15:0] result;
    wire        zero_flag;

    alu uut (
        .src_a(src_a),
        .src_b(src_b),
        .alu_opcode(alu_opcode),
        .result(result),
        .zero_flag(zero_flag)
    );

    task task1;
        begin
            src_a = 16'h0005;
            src_b = 16'h0003;
            alu_opcode = 4'b0000; // ALU_ADD
        end
    endtask

    task task2;
        begin
            src_a = 16'h0005;
            src_b = 16'h0003;
            alu_opcode = 4'b0001; // ALU_SUB
        end
    endtask

    task task3;
        begin
            src_a = 16'h0005;
            src_b = 16'h0001;
            alu_opcode = 4'b0010; // ALU_SLL
        end
    endtask

    task task4;
        begin
            src_a = 16'h0005;
            src_b = 16'h0003;
            alu_opcode = 4'b0011; // ALU_AND
        end
    endtask

    task task5;
        begin
            src_a = 16'h0005;
            src_b = 16'h0005;
            alu_opcode = 4'b0001; // ALU_SUB Zero flag test
        end
    endtask


    initial begin
        task1;
        #10;
        task2;
        #10;   
        task3;
        #10;
        task4;
        #10;
        task5;
        #10;
        $finish;
    end

endmodule