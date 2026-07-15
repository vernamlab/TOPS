set_device -family {PolarFireSoC} -die {MPFS095T} -speed {-1}
read_adl {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.adl}
read_afl {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\top.afl}
map_netlist
read_sdc {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\constraint\clocks.sdc}
check_constraints {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\constraint\placer_sdc_errors.log}
estimate_jitter -report {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\place_and_route_jitter_report.txt}
write_sdc -mode layout {C:\Users\KyleM\Documents\phd_shite\polarfire\BTCMR\designer\top\place_route.sdc}
