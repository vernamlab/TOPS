set_property ALLOW_COMBINATORIAL_LOOPS TRUE [get_nets uart_top/ro_module/*]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_in]
set_property PACKAGE_PIN H12 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
set_property PULLTYPE PULLDOWN [get_ports clk_in]
create_clock -period 80.000 -name clk_in [get_ports clk_in]

set_property IOSTANDARD LVCMOS33 [get_ports clk_output]
set_property PACKAGE_PIN E10 [get_ports clk_output]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN B10 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports uart_rx_line]
set_property PACKAGE_PIN E12 [get_ports uart_rx_line]
set_property IOSTANDARD LVCMOS33 [get_ports uart_tx_line]
set_property PACKAGE_PIN D10 [get_ports uart_tx_line]


set_property IOSTANDARD LVCMOS33 [get_ports ro_output]
set_property PACKAGE_PIN B11 [get_ports ro_output]


#| J2 (pin) | HDL port index | Package pin |
#| -------- | -------------: | ----------- |
#| 1        |      `pmod[0]` | **H12**     |
#| 2        |      `pmod[1]` | **B10**     |
#| 3        |      `pmod[2]` | **E10**     |
#| 4        |      `pmod[3]` | **E12**     |
#| 5        |      `pmod[4]` | **D10**     |
#| 6        |      `pmod[5]` | **D11**     |
#| 7        |      `pmod[6]` | **C11**     |
#| 8        |      `pmod[7]` | **B11**     |
