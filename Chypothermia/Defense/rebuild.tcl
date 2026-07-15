#-----------------------------------------------------------------------------
# rebuild.tcl -- recreate and build the RO-farm countermeasure project.
#
#   Usage (batch):  vivado -mode batch -source rebuild.tcl
#   Usage (GUI):    Tools -> Run Tcl Script... -> rebuild.tcl
#
#   Target board:   Digilent Arty S7-50
#   Target FPGA:    xc7s50csga324-1  (Spartan-7)
#   Developed on:   Vivado 2023.1  (any Spartan-7-capable version should work)
#
# All paths below are anchored to this script's own location, so the script
# works from any current directory and contains no machine-specific paths.
#-----------------------------------------------------------------------------

set script_dir [file dirname [file normalize [info script]]]

set proj_name "RO_farm_Spartan7"
set part      "xc7s50csga324-1"
set top       "top_module"

# Recreate the project inside build/ (gitignored, safe to delete).
set build_dir "$script_dir/build"
file mkdir $build_dir
create_project -force $proj_name $build_dir -part $part

# Add HDL sources and constraints, relative to this script.
add_files -norecurse [glob "$script_dir/src/*.v"]
add_files -fileset constrs_1 -norecurse "$script_dir/xdc/cons.xdc"

set_property top $top [current_fileset]
update_compile_order -fileset sources_1

# NOTE: the ring oscillators are intentional combinational loops. They are
# preserved via KEEP/DONT_TOUCH in the RTL, and cons.xdc sets
# ALLOW_COMBINATORIAL_LOOPS so the tools don't error on them.

# Synthesis -> implementation -> bitstream. Adjust -jobs to your core count.
launch_runs synth_1 -jobs 4
wait_on_run synth_1

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

# Copy the finished bitstream next to this script for convenience.
set bit "$build_dir/$proj_name.runs/impl_1/$top.bit"
if {[file exists $bit]} {
    file copy -force $bit "$script_dir/$top.bit"
    puts "BUILD OK: bitstream written to $script_dir/$top.bit"
} else {
    puts "WARNING: bitstream not found at $bit -- check the run logs above."
}
