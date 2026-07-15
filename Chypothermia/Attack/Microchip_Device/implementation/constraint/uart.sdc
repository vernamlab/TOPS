create_clock -name ext_clk_12p5MHz -period 80.000 [get_ports {clk}]

#create_clock -name osc_2MHz -period 500.000 [get_nets {sys_clk_orig.PF_OSC_C0_0.PF_OSC_C0_0.I_OSC_2_CLK_c}]

#create_generated_clock -name pll_clk_out -source [get_nets {sys_clk_orig.PF_OSC_C0_0.PF_OSC_C0_0.I_OSC_2_CLK_c}] \
#    -period 500.000 [get_nets {pll_module.ccc_module.PF_CCC_C2_0.PF_CCC_C2_0.pll_inst_0_clkint_0}]