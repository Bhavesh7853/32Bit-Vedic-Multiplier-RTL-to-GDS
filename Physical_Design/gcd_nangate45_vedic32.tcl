# 32-bit Vedic multiplier complete physical-design flow

source "helpers.tcl"
source "flow_helpers.tcl"
source "Nangate45/Nangate45.vars"

set design "Vedic_32x32"
set top_module "vedic32x32"
set synth_verilog "netlist_vedic32.v"
set sdc_file "top.sdc"

set die_area {0 0 360 380}
set core_area {15 20 330 340}

# Keep individual stage scripts disabled
# source "floorplan_flow.tcl"
# source "flow_pdn.tcl"
# source "flow_global_placement.tcl"
# source "flow_detailed_placement.tcl"
# source "flow_cts.tcl"

# Run the complete flow
source "flow.tcl"