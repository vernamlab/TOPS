set_component PF_CCC_C2_PF_CCC_C2_0_PF_CCC
# Microchip Technology Inc.
# Date: 2026-Jun-16 11:47:37
#

# Base clock for PLL #0
create_clock -period 500 [ get_pins { pll_inst_0/REF_CLK_0 } ]
create_generated_clock -divide_by 1 -source [ get_pins { pll_inst_0/REF_CLK_0 } ] -phase 0 [ get_pins { pll_inst_0/OUT0 } ]
