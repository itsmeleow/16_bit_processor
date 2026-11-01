module tb_imm_gen;

    reg [15:0] instruction;
    wire [15:0] imm_value;

    imm_gen uut (
        .instruction(instruction),
        .imm_value(imm_value)
    );

    task task1;
        begin
            instruction = 16'h1ABC;
        end
    endtask

    task task2;
        begin
           instruction = 16'h2BCA ;
        end
    endtask

    task task3;
        begin
            instruction = 16'h3CAB;
        end
    endtask

    task task4;
        begin
            instruction = 16'h4ABC;
        end
    endtask

    task task5;
        begin
            instruction = 16'h5ABC;
        end
    endtask

    task task6;
        begin
            instruction = 16'h6ABC;
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
        $finish
    end

endmodule