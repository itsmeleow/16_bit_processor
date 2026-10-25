module reg_file (
    input  wire        clk,
    input  wire [3:0]  reg_src, //RS [7:4]
    input  wire [3:0]  reg_dest, //RT/RD [11:8]
    input  wire [15:0] write_data,
    input  wire        reg_write, // 1 = write, 0 = read from the CU

    output wire [15:0] read_data1,
    output wire [15:0] read_data2
);

    reg [15:0] registers [0:15]; // Reg file 16 registers of 16 bit wide, $s0-$s15

    always @(posedge clk) begin
        if (reg_write) begin
            registers[reg_dest] <= write_data; 
        end
    end

    assign read_data1 = registers[reg_src];
    assign read_data2 = registers[reg_dest];
endmodule
