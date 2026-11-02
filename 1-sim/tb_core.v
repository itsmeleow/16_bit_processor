module tb_core ();
    localparam CLK_PERIOD = 10; // Clock period in ns (100MHz)

    reg clk;
    reg rst_n;
    reg [6:0] seg;
    reg [3:0] an;
    reg [15:0] led;

    // design under test (DUT) instantiation
    core dut (
        .clk(clk),
        .rst_n(rst_n),
        .seg(seg),
        .an(an),
        .led(led)
    );

    // generate clock signal
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        // Initialize reset
        rst_n = 0;
        #20; // Hold reset for 20 ns
        rst_n = 1;

        // Wait for some time to observe the behavior of the DUT
        #10000; // Wait for 10,000 ns

        // Finish simulation
        $finish;
    end
endmodule
