module tb_instr_mem;

  reg [15:0] read_addr;
  wire [15:0] instruction;

  // Instantiate the instruction memory module
  instr_mem uut (
    .read_addr(read_addr),
    .instruction(instruction)
  );

    integer i; //counter for loop

    task initialize;
        begin
        read_addr = 16'h0000;
        end
    endtask

    task loop_memory;
        begin
            for (i = 0; i < 10; i = i + 1) 
                begin
                    read_addr = i * 2; // Addressing word-aligned instructions
                    #10; // Wait for some time to simulate read delay
                end
        end
    endtask

  // Test sequence
  initial begin

    initialize;

    loop_memory;

    $finish;
  end

endmodule