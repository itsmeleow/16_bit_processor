module tb_ctrl_unit;

    reg [3:0] opcode;
    reg [3:0] funct;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire alu_src;
    wire mem_to_reg;
    wire branch;
    wire jump;
    wire [3:0] alu_op;

    ctrl_unit uut (
        .opcode(opcode),
        .funct(funct),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)
    );

    task task1;
        begin
            opcode = 4'b0000; // R-type
            funct = 4'b0000;  // ALU_ADD
        end
    endtask

    task task2;
        begin
            opcode = 4'b0000; // R-type 
            funct = 4'b0001;  // ALU_SUB
        end
    endtask

    task task3;
        begin
            opcode = 4'b0000; // R-type 
            funct = 4'b0010;  // ALU_SLL
        end
    endtask

    task task4;
        begin
            opcode = 4'b0000; // R-type 
            funct = 4'b0011;  // ALU_AND
        end
    endtask

    task task5;
        begin
            opcode = 4'b0001; // I-type (Load)
            funct = 4'b0000;  // ALU_ADD
        end
    endtask

    task task6;
        begin
            opcode = 4'b0010; // I-type (Store)
            funct = 4'b0000;  // ALU_ADD
        end
    endtask

    task task7;
        begin
            opcode = 4'b0011; // I-type (ALU)
            funct = 4'b0000;  // ALU_ADD
        end
    endtask

    task task8;
        begin
            opcode = 4'b0100; // I-type (BEQ)
            funct = 4'b0000;  // ALU_SUB
        end
    endtask

    task task9;
        begin
            opcode = 4'b0101; // I-type (BNE)
            funct = 4'b0000;  // ALU_SUB
        end
    endtask

    task task10;
        begin
            opcode = 4'b0110; // J-type (Jump)
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
        task6;
        #10;
        task7;
        #10;
        task8;
        #10;
        task9;
        #10;
        task10;
        #10;
        $finish;
    end
endmodule
