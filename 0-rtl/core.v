module core #(
    parameter [24:0] CPU_CLOCK_DIVIDER = 25'd1666666
)(
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
    wire [15:0] display_data;

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
    assign pc_branch = pc_plus2 + (imm_value << 1);
    assign pc_jump = pc_plus2 + ({{4{current_instruction[11]}}, current_instruction[11:0]} << 1);
    assign branch_taken = branch & ((opcode == 4'h5) ? ~zero_flag : zero_flag);
    assign pc_in = !rst_n ? 16'h0 : (jump ? pc_jump : (branch_taken ? pc_branch : pc_plus2));

    assign opcode = current_instruction[15:12];
    assign funct = current_instruction[3:0];
    assign read_src = current_instruction[7:4];
    assign read_dest = current_instruction[11:8];

    assign src_a = read_data1;
    assign src_b = alu_src ? imm_value : read_data2;

    assign mem_addr = alu_result;
    assign mem_write_data = read_data2;
    
    assign write_data = mem_to_reg ? mem_read_data : alu_result;

    // we are simply slowing down the clock for the CPU so that the display can be seen clearly
    // the Basys 3 board has a 100MHz clock, so we will divide it down to ~30Hz.
    reg [24:0] clk_counter = 0;
    reg        clk_slowed = 0;
    always @(posedge clk) begin
        if (clk_counter == CPU_CLOCK_DIVIDER) begin
            clk_counter <= 25'd0;
            clk_slowed <= ~clk_slowed;
        end else begin
            clk_counter <= clk_counter + 1;
        end
    end


    pc pc_inst (
        .clk(clk_slowed),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    instr_mem im (
        .read_addr(pc_out),
        .instruction(current_instruction)
    );

    reg_file rf (
        .clk(clk_slowed),
        .reg_write(reg_write & rst_n),
        .reg_src(read_src),
        .reg_dest(read_dest),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2),
        .display_data(display_data)
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
        .clk(clk_slowed),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(mem_write_data),
        .read_data(mem_read_data)
    );

    // display the current PC value as binary value on the LEDs
    assign led = pc_out; 

    // convert the display_data from the register file to decimal digits for the seven-segment display.
    reg  [3:0]  thousand_digit, hundred_digit, ten_digit, ones_digit;
    always @(*) begin
        if (!rst_n) begin
            thousand_digit = 4'd0;
            hundred_digit = 4'd0;
            ten_digit = 4'd0;
            ones_digit = 4'd0;
        end else begin
            thousand_digit = (display_data / 1000) % 10;
            hundred_digit = (display_data / 100) % 10;
            ten_digit = (display_data / 10) % 10;
            ones_digit = display_data % 10;
        end
    end


    display display_inst (
        .clk(clk),
        .data_in({thousand_digit, hundred_digit, ten_digit, ones_digit}),
        .seg(seg),
        .an(an)
    );
endmodule
