module tb_pc;

    reg clk; 
    reg [15:0] pc_in;
    wire [15:0] pc_out;

    pc dut (
        .clk(clk),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    always begin
        #10 clk = ~clk; // Toggle clock every 10 time units
    end

    task initialize;
        begin
            clk = 0; // Initialize clock to 0
            pc_in = 16'h0000; // Initialize PC input to 0
        end
    endtask

    task test1;
        begin
            pc_in = 16'h0002; // Set PC input to 1
        end
    endtask

    task test2;
        begin
            pc_in = 16'h0004; // Set PC input to 2
        end
    endtask

    task test3;
        begin
            pc_in = 16'h0006; // Set PC input to 3
        end
    endtask

    initial begin
        initialize; // Call the initialize task
        #20 // Wait for 20 time units before starting the tests
        // Run test cases
        test1;
        #20; // Wait for 20 time units
        test2;
        #20; // Wait for 20 time units
        test3;
        #20; // Wait for 20 time units

        $finish; // End simulation
    end

endmodule