//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Jun 11 14:46:37 2025
// Version: 2024.2 2024.2.0.13
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// tamperGuy
module tamperGuy(
    // Inputs
    clk,
    clr,
    rst_n,
    zeroize,
    // Outputs
    CRITICAL_ALARM,
    HEARTBEAT,
    MASTER_ALARM,
    SLOW_CLOCK,
    VOLT_DETECT_1P0_HIGH,
    VOLT_DETECT_1P0_LOW,
    flags
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         clk;
input         clr;
input         rst_n;
input         zeroize;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        CRITICAL_ALARM;
output        HEARTBEAT;
output        MASTER_ALARM;
output        SLOW_CLOCK;
output        VOLT_DETECT_1P0_HIGH;
output        VOLT_DETECT_1P0_LOW;
output [31:0] flags;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          clk;
wire          clr;
wire          CRITICAL_ALARM_net_0;
wire   [31:0] flags_net_0;
wire          HEARTBEAT_net_0;
wire          MASTER_ALARM_net_0;
wire          rst_n;
wire          SLOW_CLOCK_net_0;
wire          VOLT_DETECT_1P0_HIGH_net_0;
wire          VOLT_DETECT_1P0_LOW_net_0;
wire          zeroize;
wire          SLOW_CLOCK_net_1;
wire          MASTER_ALARM_net_1;
wire          CRITICAL_ALARM_net_1;
wire          VOLT_DETECT_1P0_LOW_net_1;
wire          VOLT_DETECT_1P0_HIGH_net_1;
wire          HEARTBEAT_net_1;
wire   [31:0] flags_net_1;
wire   [31:0] CLEAR_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net     = 1'b0;
assign VCC_net     = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SLOW_CLOCK_net_1           = SLOW_CLOCK_net_0;
assign SLOW_CLOCK                 = SLOW_CLOCK_net_1;
assign MASTER_ALARM_net_1         = MASTER_ALARM_net_0;
assign MASTER_ALARM               = MASTER_ALARM_net_1;
assign CRITICAL_ALARM_net_1       = CRITICAL_ALARM_net_0;
assign CRITICAL_ALARM             = CRITICAL_ALARM_net_1;
assign VOLT_DETECT_1P0_LOW_net_1  = VOLT_DETECT_1P0_LOW_net_0;
assign VOLT_DETECT_1P0_LOW        = VOLT_DETECT_1P0_LOW_net_1;
assign VOLT_DETECT_1P0_HIGH_net_1 = VOLT_DETECT_1P0_HIGH_net_0;
assign VOLT_DETECT_1P0_HIGH       = VOLT_DETECT_1P0_HIGH_net_1;
assign HEARTBEAT_net_1            = HEARTBEAT_net_0;
assign HEARTBEAT                  = HEARTBEAT_net_1;
assign flags_net_1                = flags_net_0;
assign flags[31:0]                = flags_net_1;
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign CLEAR_net_0 = { clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , 1'b1 , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr , clr };
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORESMIP_PF_C0
CORESMIP_PF_C0 CORESMIP_PF_C0_0(
        // Inputs
        .CLK                        ( clk ),
        .RESET_N                    ( rst_n ),
        .IO_DISABLE                 ( GND_net ),
        .LOCKDOWN                   ( GND_net ),
        .RESET_DEVICE               ( GND_net ),
        .USER_ALARM                 ( GND_net ),
        .DELAY_ZEROIZE_P            ( GND_net ),
        .DELAY_ZEROIZE_N            ( VCC_net ),
        .ERASE_P                    ( zeroize ),
        .ERASE_N                    ( VCC_net ),
        .VOLT_DETECT_1P0_HIGH_CLEAR ( clr ),
        .VOLT_DETECT_1P0_LOW_CLEAR  ( clr ),
        .VOLT_DETECT_1P8_HIGH_CLEAR ( GND_net ),
        .VOLT_DETECT_1P8_LOW_CLEAR  ( GND_net ),
        .VOLT_DETECT_2P5_HIGH_CLEAR ( GND_net ),
        .VOLT_DETECT_2P5_LOW_CLEAR  ( GND_net ),
        .CLEAR                      ( CLEAR_net_0 ),
        // Outputs
        .SLOW_CLOCK                 ( SLOW_CLOCK_net_0 ),
        .HEARTBEAT                  ( HEARTBEAT_net_0 ),
        .MASTER_ALARM               ( MASTER_ALARM_net_0 ),
        .CRITICAL_ALARM             ( CRITICAL_ALARM_net_0 ),
        .VOLT_DETECT_1P0_HIGH       ( VOLT_DETECT_1P0_HIGH_net_0 ),
        .VOLT_DETECT_1P0_LOW        ( VOLT_DETECT_1P0_LOW_net_0 ),
        .VOLT_DETECT_1P8_HIGH       (  ),
        .VOLT_DETECT_1P8_LOW        (  ),
        .VOLT_DETECT_2P5_HIGH       (  ),
        .VOLT_DETECT_2P5_LOW        (  ),
        .FLAGS                      ( flags_net_0 ),
        .RESET_REASON               (  ) 
        );


endmodule
