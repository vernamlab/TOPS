//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jun 16 11:49:50 2026
// Version: 2025.2 2025.2.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// ccc_module
module ccc_module(
    // Inputs
    ref_clk,
    // Outputs
    out_clk,
    pll_lock
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  ref_clk;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output out_clk;
output pll_lock;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   out_clk_net_0;
wire   pll_lock_net_0;
wire   ref_clk;
wire   pll_lock_net_1;
wire   out_clk_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign pll_lock_net_1 = pll_lock_net_0;
assign pll_lock       = pll_lock_net_1;
assign out_clk_net_1  = out_clk_net_0;
assign out_clk        = out_clk_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_CCC_C2
PF_CCC_C2 PF_CCC_C2_0(
        // Inputs
        .REF_CLK_0     ( ref_clk ),
        // Outputs
        .OUT0_FABCLK_0 ( out_clk_net_0 ),
        .PLL_LOCK_0    ( pll_lock_net_0 ) 
        );


endmodule
