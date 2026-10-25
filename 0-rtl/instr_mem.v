module instr_mem (
    parameter MEM_SIZE = 128,
    parameter DATA_WIDTH = 16,

    input wire [DATA_WIDTH - 1:0] read_addr, // address to read instruction from    

    output wire [DATA_WIDTH - 1:0] instruction //output instr to the CU
);

    reg [DATA_WIDTH - 1:0] memory [0:MEM_SIZE - 1]; //  words of 16-bit instruction memory 128 mem locations
/*
    Initialze the instructions focusing on opcode and func code. If they dont use func code like I/J type then just make it arbitary value F
    Reg inputs are arbitrary values 1 and 2. 
    Put the instructions later in some seperate file later
*/
    initial begin 
        //R types
        memory[0] = 16'h0120; // add 00 12 00, opcode |rt| rs| func
        memory[1] = 16'h0121; // sub 
        memory[2] = 16'h0122; // sll
        memory[3] = 16'h0123; // and

        //I types
        memory[4] = 16'h112F; // lw  
        memory[5] = 16'h212F; // sw
        memory[6] = 16'h312F; // addi
        memory[7] = 16'h412F; // beq
        memory[8] = 16'h512F; // bne

        //J types
        memory[9] = 16'h6FFF; // jmp
    end

    assign instruction = memory[read_addr >> 1]; // divide by 2 to get the word address


endmodule
