set_property ALLOW_COMBINATORIAL_LOOPS true [get_nets uart_top/ro_module/*]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_in_IBUF]

## clk = 12MHz 
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports clk_internal]
create_clock -period 83.333 -name sys_clk_pin -waveform {0.000 41.667} -add [get_ports clk_internal]

## Buttons
set_property -dict {PACKAGE_PIN G15 IOSTANDARD LVCMOS33} [get_ports rst]

## Pmod Header JA
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports clk_in]
#set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports ]; #IO_L4N_T0_D05_14 Sch=ja_n[1]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports clk_output]
#set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports {  }]; #IO_L5N_T0_D07_14 Sch=ja_n[2]
#set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports {  }]; #IO_L7P_T1_D09_14 Sch=ja_p[3]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports ro_output]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports uart_rx_line]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports uart_tx_line]


## Configuration options, can be used for all designs
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property INTERNAL_VREF 0.675 [get_iobanks 34]

