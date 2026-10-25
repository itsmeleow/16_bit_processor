module core (
    input  wire        clk,
    input  wire        rst_n,
    output wire [6:0]  seg,
    output wire [3:0]  an,
    output wire [15:0] led
);
    // initialize the wires for interconnecting the modules
    wire [15:0] pc_in, pc_out;
    wire [15:0] current_instruction;

    wire [3:0]  read_src, read_dest;
    wire [15:0] read_data1, read_data2, write_data;

    wire [3:0]  opcode, funct;
    wire        reg_write;
    wire        mem_read;
    wire        mem_write;
    wire        alu_src;
    wire        mem_to_reg;
    wire        branch;
    wire        jump;
    wire [3:0]  alu_op;

    wire [15:0] src_a, src_b;
    wire [15:0] alu_result;
    wire        zero_flag;

    wire [15:0] mem_addr;
    wire [15:0] mem_write_data;
    wire [15:0] mem_read_data;
    wire [15:0] imm_value;

    wire        branch_taken;
    wire [15:0] pc_plus2, pc_branch, pc_jump;
    
    assign pc_plus2 = pc_out + 16'd2;
    assign pc_branch = pc_out + (imm_value << 1);
    assign pc_jump = pc_plus2 + (current_instruction[11:0] << 1);
    assign branch_taken = branch & zero_flag;
    assign pc_in = !rst_n ? 16'h0 : (jump ? pc_jump : (branch_taken ? pc_branch : pc_plus2));

    assign opcode = current_instruction[15:12];
    assign funct = current_instruction[3:0];
    assign read_src = current_instruction[11:8];
    assign read_dest = current_instruction[7:4];

    assign src_a = read_data1;
    assign src_b = alu_src ? imm_value : read_data2;

    assign mem_addr = alu_result;
    assign mem_write_data = read_data2;
    
    assign write_data = mem_to_reg ? mem_read_data : alu_result;

    pc pc_inst (
        .clk(clk),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    instr_mem im (
        .addr(pc_out),
        .instruction(current_instruction)
    );

    reg_file rf (
        .clk(clk),
        .reg_write(reg_write),
        .reg_src(read_src),
        .reg_dest(read_dest),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    ctrl_unit cu (
        .opcode(opcode),
        .funct(funct),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .branch(branch),
        .jump(jump),
        .alu_op(alu_op)
    );

    imm_gen ig (
        .instruction(current_instruction),
        .imm_value(imm_value)
    );
 
    alu alu_inst (
        .src_a(src_a),
        .src_b(src_b),
        .alu_opcode(alu_op),
        .result(alu_result),
        .zero_flag(zero_flag)
    );

    data_mem dm (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(mem_write_data),
        .read_data(mem_read_data)
    );

    assign led = alu_result; // display the ALU result on the LEDs

    // add 7-segment display logic here

endmodule
