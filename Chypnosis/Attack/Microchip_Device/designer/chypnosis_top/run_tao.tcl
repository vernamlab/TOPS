set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_verilog -mode system_verilog_mfcu {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\hdl\chypnosis_top.v}
read_verilog -mode system_verilog_mfcu {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\component\Actel\DirectCore\CORESMIP_PF\2.0.100\rtl\vlog\core_obfuscated\coresmip_pf.v}
read_verilog -mode system_verilog_mfcu {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\component\work\CORESMIP_PF_C0\CORESMIP_PF_C0.v}
read_verilog -mode system_verilog_mfcu {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\component\work\tamperGuy\tamperGuy.v}
set_top_level {chypnosis_top}
map_netlist
check_constraints {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\KyleM\Documents\phd_shite\polarfire\chypnosis\designer\chypnosis_top\synthesis.fdc}
