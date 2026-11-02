module tb_core;

    reg clk;
    reg rst_n;
    wire [6:0] seg;
    wire [3:0] an;
    wire [15:0] led;

    core uut (
        .clk(clk),
        .rst_n(rst_n),
        .seg(seg),
        .an(an),
        .led(led)
    );

    always begin
        #10 clk = ~clk; // Toggle clock every 10 time units
    end

    task initialize;
        begin
            clk = 0; // Initialize clock to 0
            rst_n = 0; // Initialize reset to 0 (active low)

            uut.rf.registers[0] <= 16'h0000; // Initialize register $s0 to 0
            uut.rf.registers[1] <= 16'h000A; // Initialize register $s1 to A
            uut.rf.registers[2] <= 16'h000B; // Initialize register $s2 to B
            uut.rf.registers[3] <= 16'h000C; // Initialize register $s3 to C
        end
    endtask

    task release_reset;
        begin
            rst_n = 1; // Release reset
        end
    endtask

    always @(posedge clk) begin // Monitor the core's internal signals on each clock edge, for debugging
        #1 // Wait for 1 time unit to allow signals to settle
        $display("Time: %0t PC: %h, Instruction: %h ALU_Result: %h Reg_src: %h Reg_dest: %h",
                  $time, uut.pc_out, uut.current_instruction, uut.alu_result, uut.read_src, uut.read_dest);
    end

    initial begin
        initialize; // Call the initialize task
        release_reset; // Release reset
        #500 
        $finish; 
    end

endmodule