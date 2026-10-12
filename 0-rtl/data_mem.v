module data_mem (
    parameter MEM_SIZE = 256,
    parameter DATA_WIDTH = 16,

    input  wire                  clk,
    input  wire                  mem_read,          // read enable
    input  wire                  mem_write,         // write enable
    input  wire [DATA_WIDTH-1:0] addr,              // memory address to read/write
    input  wire [DATA_WIDTH-1:0] write_data,        // data to write to memory
    output reg  [DATA_WIDTH-1:0] read_data          // data read from memory
);
    // currently, the memory is word-addressable, however will change to byte addressable.

    // memory array
    reg [DATA_WIDTH-1:0] mem_array [0:MEM_SIZE-1];

    always @(posedge clk) begin
        if (mem_write) begin
            mem_array[addr] <= write_data;  // write data to memory
        end
        if (mem_read) begin
            read_data <= mem_array[addr];    // read data from memory
        end
    end

endmodule