# Microchip Technology Inc.
# Date: 2025-Jun-04 13:15:03
# This file was generated based on the following SDC source files:
#   C:/Users/KyleM/Documents/phd_shite/polarfire/BTCMR/constraint/clocks.sdc
#

create_clock -name {clk} -period 20 [ get_ports { clk } ]
create_clock -name {sys_clk} -period 20 [ get_nets { sys_clk } ]
set_clock_uncertainty 0.0005913 [ get_clocks { clk } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { clk } ] -rise_to [ get_clocks { clk } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { clk } ] -fall_to [ get_clocks { clk } ]
set_clock_uncertainty 0.0005913 [ get_clocks { sys_clk } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { sys_clk } ] -rise_to [ get_clocks { sys_clk } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { sys_clk } ] -fall_to [ get_clocks { sys_clk } ]
