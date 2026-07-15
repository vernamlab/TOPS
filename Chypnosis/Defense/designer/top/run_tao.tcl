set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_verilog -mode system_verilog {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\hdl\CMR.v}
read_verilog -mode system_verilog {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\component\work\PF_CCC_C0\PF_CCC_C0_0\PF_CCC_C0_PF_CCC_C0_0_PF_CCC.v}
read_verilog -mode system_verilog {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\component\work\PF_CCC_C0\PF_CCC_C0.v}
read_verilog -mode system_verilog {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\component\work\PLLsmrt\PLLsmrt.v}
read_verilog -mode system_verilog {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\hdl\top.v}
set_top_level {top}
map_netlist
check_constraints {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\synthesis.fdc}
