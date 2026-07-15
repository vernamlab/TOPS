#LEDs
set_property DRIVE 8 [get_ports led1]
set_property PACKAGE_PIN T2 [get_ports led1]
set_property IOSTANDARD LVCMOS33 [get_ports led1]

set_property DRIVE 8 [get_ports led2]
set_property PACKAGE_PIN T3 [get_ports led2]
set_property IOSTANDARD LVCMOS33 [get_ports led2]

set_property DRIVE 8 [get_ports led3]
set_property PACKAGE_PIN T4 [get_ports led3]
set_property IOSTANDARD LVCMOS33 [get_ports led3]


#UART
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN A12 [get_ports rst]
set_property PACKAGE_PIN A14 [get_ports uart_rx_line]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx_line]
set_property PACKAGE_PIN A15 [get_ports uart_tx_line]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx_line]


#PLL Connections
set_property PACKAGE_PIN N13 [get_ports pll_clk1_org]
#set_property PACKAGE_PIN E12 [get_ports pll_clk2]

create_clock -period 10.000 -name pll_clk1_org -waveform {0.000 5.000} [get_nets pll_clk1_org]
set_property IOSTANDARD LVCMOS33 [get_ports pll_clk1_org]



set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

set_property BITSTREAM.CONFIG.USR_ACCESS TIMESTAMP [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]



