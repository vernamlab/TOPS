set_property CFGBVS VCCO        [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {jb_en[0]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {jb_en[1]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {jb_en[2]}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {jb_en[3]}]

set_property PULLDOWN true [get_ports {jb_en[0]}]
set_property PULLDOWN true [get_ports {jb_en[1]}]
set_property PULLDOWN true [get_ports {jb_en[2]}]
set_property PULLDOWN true [get_ports {jb_en[3]}]

set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN E13 IOSTANDARD LVCMOS33} [get_ports {led[2]}] 
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {led[3]}]

set_property ALLOW_COMBINATORIAL_LOOPS true \
  [get_nets -hier -regexp {.*RO_FARM_[0-9]+/GEN_RO\[[0-9]+\][./]ro_inst/b\[[0-9]+\]$}]