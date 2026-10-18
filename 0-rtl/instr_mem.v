module instr_mem (
    input wire [15:0] read_addr, // address to read instruction from    

    output wire [15:0] instruction //output instr to the CU
);

    reg [15:0] memory [0:127]; //  words of 16-bit instruction memory 128 mem locations
/*
    Initialze the instructions focusing on opcode and func code. If they dont use func code like I/J type then just make it arbitary value F
    Reg inputs are arbitrary values 1 and 2. 
    Put the instructions later in some seperate file later
*/
    initial begin 
        //R types
        memory[0] = 16'h0120; // add 00 12 00, opcode |rt| rs| func
        memory[2] = 16'h0121; // sub 
        memory[4] = 16'h0122; // sll
        memory[6] = 16'h0123; // and

        //I types
        memory[8] = 16'h112F; // lw  
        memory[10] = 16'h212F; // sw
        memory[12] = 16'h312F; // addi
        memory[14] = 16'h412F; // beq
        memory[16] = 16'h512F; // bne

        //J types
        memory[18] = 16'h6FFF; // jmp
    end

    assign instruction = memory[read_addr >> 1]; // divide by 2 to get the word address


endmodule
   
   