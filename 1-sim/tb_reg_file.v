module tb_reg_file;

    reg clk;
    reg [3:0] reg_src;
    reg [3:0] reg_dest; 
    reg [15:0] write_data;
    reg reg_write;

    wire [15:0] read_data1;
    wire [15:0] read_data2;

    reg_file dut (
        .clk(clk),
        .reg_src(reg_src),
        .reg_dest(reg_dest),
        .write_data(write_data),
        .reg_write(reg_write),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    task initialize;
        begin
            clk = 0;
            reg_src = 4'b0000; // Read from register 1
            reg_dest = 4'b0000; // Write to register 2
            write_data = 16'h0000; // Data to write
            reg_write = 0; // Enable write
        end
    endtask

    always begin
        #10 clk = ~clk; // Toggle clock every 10 time units
    end

    task test1;
        begin
            reg_src = 4'b0001; // Change source register to 1
            reg_dest = 4'b0010; // Change destination register to 2
            write_data = 16'hABCD; // Change data to write register 2 = 16'hABCD
            reg_write = 1; // Enable write
        end
    endtask

    task test2;
        begin
            reg_src = 4'b0001; // Change source register to 1
            reg_dest = 4'b0010; // Change destination register to 2
            write_data = 16'hDCBA; // Change data to write register 2 doesnt change because reg_write is 0
            reg_write = 0; // Disable write to read from the CU
        end
    endtask

    task test3;
        begin
            reg_src = 4'b0001; // Change source register to 1
            reg_dest = 4'b0010; // Change destination register to 2
            write_data = 16'h1234; // Change data to write register 2 now there should be new values
            reg_write = 1; // Enable write
        end
    endtask

    task test4;
        begin
            reg_src = 4'b0010; // Change source register to 2
            reg_dest = 4'b0001; // Change destination register to 1
            write_data = 16'h5678; // Change data to write register 1 now there should be new values
            reg_write = 1; // Enable write
        end
    endtask

    initial begin
        initialize;

        #20; // Wait for 20 time units then start
        //TEST 1 regular write and read
        test1;
        #20; // Wait for 20 time units
        //TEST 2 Doesnt write if reg_write is 0 and reads from the CU
        test2;
        #20; // Wait for 20 time units
        //TEST 3 Write to register 2 and read from register 1 and 2
        test3;
        #20; // Wait for 20 time units
        //TEST 4 Write to register 1 and read from register 1 and 2
        test4;
        #20; // Wait for 20 time units
    $finish; // End the simulation
    end


endmodule