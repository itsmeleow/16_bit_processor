# ignore - only for OpenROAD GDS flow
export DESIGN_NAME = core
export PLATFORM = sky130hd

export VERILOG_FILES = \
    $(wildcard /data/code/rtl/16_bit_processor/0-rtl/*.v) \
    $(wildcard /data/code/rtl/16_bit_processor/0-rtl/*.sv)

export SDC_FILE = /data/code/rtl/16_bit_processor/2-constraints/constraints.sdc

export CORE_UTILIZATION = 40
export PLACE_DENSITY = 0.50
