module instr_mem #(
    parameter MEM_SIZE = 128,
    parameter DATA_WIDTH = 16
)(
    input  wire [DATA_WIDTH-1:0] read_addr, // address to read instruction from    
    output wire [DATA_WIDTH-1:0] instruction //output instr to the CU
);

    reg [DATA_WIDTH-1:0] memory [0:MEM_SIZE-1]; //  words of 16-bit instruction memory 128 mem locations

    // Fibonacci
    // The program computes the first 10 Fibonacci numbers, printing each one as a decimal value to the 7-segment display
    // -- we are using r0 as the zero register and r7 is used by the reg_file to display values for the 7-segment display
    // Instruction Encodings:
    // R-Type [opcode][rt/rd][rs][function]
    // I-Type [opcode][rt/rd][rs][immediate]
    // J-Type [opcode][address]

    integer i;
    initial begin
        memory[0]  = 16'h3100; // PC 0: addi r1, r0, 0   ; first = 0
        memory[1]  = 16'h3201; // PC 2: addi r2, r0, 1   ; second = 1
        memory[2]  = 16'h3400; // PC 4: addi r4, r0, 0   ; counter = 0
        memory[3]  = 16'h3505; // PC 6: addi r5, r0, 5   ; limit = 5
        memory[4]  = 16'h3555; // PC 8: addi r5, r5, 5   ; limit = 10

        // start of LOOP
        memory[5]  = 16'h5541; // PC 10: bne r4, r5, +1   ; branch to PC 14 if counter != limit
        memory[6]  = 16'h6007; // PC 12: jmp +7           ; jmp to END the program at PC 28
        memory[7]  = 16'h3310; // PC 14: addi r3, r1, 0   ; copy first
        memory[8]  = 16'h0320; // PC 16: add r3, r2       ; sum = first + second
        memory[9]  = 16'h3120; // PC 18: addi r1, r2, 0   ; first = second
        memory[10] = 16'h3230; // PC 20: addi r2, r3, 0   ; second = sum
        memory[11] = 16'h3730; // PC 22: addi r7, r3, 0   ; display r3 on the 7-segment display
        memory[12] = 16'h3441; // PC 24: addi r4, r4, 1   ; counter++
        memory[13] = 16'h6FF7; // PC 26: jmp -9           ; LOOP back to PC 10

        memory[14] = 16'h3700; // PC 28: addi r7, r0, 0   ; END: reset the display to 0
        memory[15] = 16'h6FFF; // PC 30: jmp -1           ; ends and stays here
    end

    assign instruction = memory[read_addr >> 1]; // divide by 2 to get the word address
endmodule
