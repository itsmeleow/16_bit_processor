module tb_data_mem;

    reg clk;
    reg mem_read;
    reg mem_write;
    reg [15:0] addr;
    reg [15:0] write_data;
    wire [15:0] read_data;

    // Instantiate the data_mem module
    data_mem uut (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generation
    always begin
        #10 clk = ~clk; // Toggle clock every 10 time units
    end

    task initialize;
        begin
            clk = 0; // Initialize clock to 0
            mem_read = 0; // Initialize read enable to 0
            mem_write = 0; // Initialize write enable to 0
            addr = 0; // Initialize address to 0
            write_data = 0; // Initialize write data to 0
        end
    endtask

    task write_data_to_memory;
        input [15:0] address;
        input [15:0] data;
        begin
            mem_write = 1; // Enable write
            addr = address; // Set address
            write_data = data; // Set data to write
            #10; // Wait for one clock cycle
            mem_write = 0; // Disable write
        end
    endtask

    task read_data_from_memory;
        input [15:0] address;
        begin
            mem_read = 1; // Enable read
            addr = address; // Set address
            #10; // Wait for one clock cycle
            mem_read = 0; // Disable read
        end
    endtask

    // Test sequence
    initial begin
        initialize; // Call the initialize task
        // Wait for a few clock cycles
        #20;
        // Write data to memory
        write_data_to_memory(4, 16'hABCD); // Write 0xABCD to address 4
        // Read data from memory
        read_data_from_memory(4); 

        write_data_to_memory(8, 16'hBCDA);

        read_data_from_memory(8);

        $finish; // End simulation
    end