//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Jun  4 16:17:19 2025
// Version: 2024.2 2024.2.0.13
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// PLLsmrt
module PLLsmrt(
    // Inputs
    clk,
    powerdown_n,
    // Outputs
    locked,
    sys_clk
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  clk;
input  powerdown_n;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output locked;
output sys_clk;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   clk;
wire   locked_net_0;
wire   powerdown_n;
wire   sys_clk_net_0;
wire   sys_clk_net_1;
wire   locked_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign sys_clk_net_1 = sys_clk_net_0;
assign sys_clk       = sys_clk_net_1;
assign locked_net_1  = locked_net_0;
assign locked        = locked_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_CCC_C0
PF_CCC_C0 PF_CCC_C0_0(
        // Inputs
        .REF_CLK_0         ( clk ),
        .PLL_POWERDOWN_N_0 ( powerdown_n ),
        // Outputs
        .OUT0_FABCLK_0     ( sys_clk_net_0 ),
        .PLL_LOCK_0        ( locked_net_0 ) 
        );


endmodule
