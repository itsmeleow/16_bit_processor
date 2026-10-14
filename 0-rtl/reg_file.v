module reg_file (
    input wire [3:0] Reg_Src, //RS [7:4]
    input wire [3:0] Reg_Dest, //RT/RD [11:8]
    input wire [15:0] Write_data,
    input wire RegWrite, // 1 = write, 0 = read from the CU

    input wire clk,

    output wire [15:0] Read_data1,
    output wire [15:0] Read_data2
);

    reg [15:0] registers [0:15]; // Reg file 16 registers of 16 bit wide, $s0-$s15

    always @(posedge clk) begin
        if (RegWrite) begin
            registers[Reg_Dest] <= Write_data; 
        end
    end

    assign Read_data1 = registers[Reg_Src];
    assign Read_data2 = registers[Reg_Dest];



endmodule