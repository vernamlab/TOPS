//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jun 16 13:30:33 2026
// Version: 2025.2 2025.2.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// tvs_module
module tvs_module(
    // Outputs
    active,
    channel,
    temp_high,
    temp_low,
    valid,
    value
);

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        active;
output [1:0]  channel;
output        temp_high;
output        temp_low;
output        valid;
output [15:0] value;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          active_net_0;
wire   [1:0]  channel_net_0;
wire          temp_high_net_0;
wire          temp_low_net_0;
wire          valid_net_0;
wire   [15:0] value_net_0;
wire          temp_high_net_1;
wire          temp_low_net_1;
wire   [15:0] value_net_1;
wire   [1:0]  channel_net_1;
wire          valid_net_1;
wire          active_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
assign VCC_net = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign temp_high_net_1 = temp_high_net_0;
assign temp_high       = temp_high_net_1;
assign temp_low_net_1  = temp_low_net_0;
assign temp_low        = temp_low_net_1;
assign value_net_1     = value_net_0;
assign value[15:0]     = value_net_1;
assign channel_net_1   = channel_net_0;
assign channel[1:0]    = channel_net_1;
assign valid_net_1     = valid_net_0;
assign valid           = valid_net_1;
assign active_net_1    = active_net_0;
assign active          = active_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_TVS_C1
PF_TVS_C1 PF_TVS_C1_0(
        // Inputs
        .TEMP_HIGH_CLEAR ( GND_net ),
        .TEMP_LOW_CLEAR  ( GND_net ),
        .ENABLE_1V       ( VCC_net ),
        .ENABLE_18V      ( VCC_net ),
        .ENABLE_25V      ( VCC_net ),
        .ENABLE_TEMP     ( VCC_net ),
        // Outputs
        .TEMP_HIGH       ( temp_high_net_0 ),
        .TEMP_LOW        ( temp_low_net_0 ),
        .VALUE           ( value_net_0 ),
        .CHANNEL         ( channel_net_0 ),
        .VALID           ( valid_net_0 ),
        .ACTIVE          ( active_net_0 ) 
        );


endmodule
