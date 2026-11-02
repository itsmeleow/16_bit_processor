# ignore - only for OpenROAD GDS flow
create_clock -name core_clk -period 20.000 [get_ports clk]
set_clock_uncertainty 0.200 [get_clocks core_clk]

set_input_delay 2.000 -clock core_clk [get_ports rst_n]
set_input_transition 0.200 [get_ports rst_n]

set_output_delay 2.000 -clock core_clk [all_outputs]
set_load 0.050 [all_outputs]
