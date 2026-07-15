//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jun 10 21:27:58 2025
// Version: 2024.2 2024.2.0.13
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of CORESMIP_PF_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS095T-1FCSG325E
# Create and Configure the core component CORESMIP_PF_C0
create_and_configure_core -core_vlnv {Actel:DirectCore:CORESMIP_PF:2.0.100} -component_name {CORESMIP_PF_C0} -params {\
"ENABLE_FABRIC_PDC:false"  \
"ENABLE_SECURITY_PDC:false"  \
"ENABLE_SNVM_PDC:false"  \
"VDETECTOR_ENABLE_1P0:true"  \
"VDETECTOR_ENABLE_1P8:false"  \
"VDETECTOR_ENABLE_2P5:false"  \
"ZENABLE:true"  \
"ZMODE:1"   }
# Exporting Component Description of CORESMIP_PF_C0 to TCL done
*/

// CORESMIP_PF_C0
module CORESMIP_PF_C0(
    // Inputs
    CLEAR,
    CLK,
    DELAY_ZEROIZE_N,
    DELAY_ZEROIZE_P,
    ERASE_N,
    ERASE_P,
    IO_DISABLE,
    LOCKDOWN,
    RESET_DEVICE,
    RESET_N,
    USER_ALARM,
    VOLT_DETECT_1P0_HIGH_CLEAR,
    VOLT_DETECT_1P0_LOW_CLEAR,
    VOLT_DETECT_1P8_HIGH_CLEAR,
    VOLT_DETECT_1P8_LOW_CLEAR,
    VOLT_DETECT_2P5_HIGH_CLEAR,
    VOLT_DETECT_2P5_LOW_CLEAR,
    // Outputs
    CRITICAL_ALARM,
    FLAGS,
    HEARTBEAT,
    MASTER_ALARM,
    RESET_REASON,
    SLOW_CLOCK,
    VOLT_DETECT_1P0_HIGH,
    VOLT_DETECT_1P0_LOW,
    VOLT_DETECT_1P8_HIGH,
    VOLT_DETECT_1P8_LOW,
    VOLT_DETECT_2P5_HIGH,
    VOLT_DETECT_2P5_LOW
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] CLEAR;
input         CLK;
input         DELAY_ZEROIZE_N;
input         DELAY_ZEROIZE_P;
input         ERASE_N;
input         ERASE_P;
input         IO_DISABLE;
input         LOCKDOWN;
input         RESET_DEVICE;
input         RESET_N;
input         USER_ALARM;
input         VOLT_DETECT_1P0_HIGH_CLEAR;
input         VOLT_DETECT_1P0_LOW_CLEAR;
input         VOLT_DETECT_1P8_HIGH_CLEAR;
input         VOLT_DETECT_1P8_LOW_CLEAR;
input         VOLT_DETECT_2P5_HIGH_CLEAR;
input         VOLT_DETECT_2P5_LOW_CLEAR;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        CRITICAL_ALARM;
output [31:0] FLAGS;
output        HEARTBEAT;
output        MASTER_ALARM;
output [4:0]  RESET_REASON;
output        SLOW_CLOCK;
output        VOLT_DETECT_1P0_HIGH;
output        VOLT_DETECT_1P0_LOW;
output        VOLT_DETECT_1P8_HIGH;
output        VOLT_DETECT_1P8_LOW;
output        VOLT_DETECT_2P5_HIGH;
output        VOLT_DETECT_2P5_LOW;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] CLEAR;
wire          CLK;
wire          CRITICAL_ALARM_net_0;
wire          DELAY_ZEROIZE_N;
wire          DELAY_ZEROIZE_P;
wire          ERASE_N;
wire          ERASE_P;
wire   [31:0] FLAGS_net_0;
wire          HEARTBEAT_net_0;
wire          IO_DISABLE;
wire          LOCKDOWN;
wire          MASTER_ALARM_net_0;
wire          RESET_DEVICE;
wire          RESET_N;
wire   [4:0]  RESET_REASON_net_0;
wire          SLOW_CLOCK_net_0;
wire          USER_ALARM;
wire          VOLT_DETECT_1P0_HIGH_net_0;
wire          VOLT_DETECT_1P0_HIGH_CLEAR;
wire          VOLT_DETECT_1P0_LOW_net_0;
wire          VOLT_DETECT_1P0_LOW_CLEAR;
wire          VOLT_DETECT_1P8_HIGH_net_0;
wire          VOLT_DETECT_1P8_HIGH_CLEAR;
wire          VOLT_DETECT_1P8_LOW_net_0;
wire          VOLT_DETECT_1P8_LOW_CLEAR;
wire          VOLT_DETECT_2P5_HIGH_net_0;
wire          VOLT_DETECT_2P5_HIGH_CLEAR;
wire          VOLT_DETECT_2P5_LOW_net_0;
wire          VOLT_DETECT_2P5_LOW_CLEAR;
wire   [31:0] FLAGS_net_1;
wire   [4:0]  RESET_REASON_net_1;
wire          SLOW_CLOCK_net_1;
wire          HEARTBEAT_net_1;
wire          MASTER_ALARM_net_1;
wire          CRITICAL_ALARM_net_1;
wire          VOLT_DETECT_1P0_HIGH_net_1;
wire          VOLT_DETECT_1P0_LOW_net_1;
wire          VOLT_DETECT_1P8_HIGH_net_1;
wire          VOLT_DETECT_1P8_LOW_net_1;
wire          VOLT_DETECT_2P5_HIGH_net_1;
wire          VOLT_DETECT_2P5_LOW_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign FLAGS_net_1                = FLAGS_net_0;
assign FLAGS[31:0]                = FLAGS_net_1;
assign RESET_REASON_net_1         = RESET_REASON_net_0;
assign RESET_REASON[4:0]          = RESET_REASON_net_1;
assign SLOW_CLOCK_net_1           = SLOW_CLOCK_net_0;
assign SLOW_CLOCK                 = SLOW_CLOCK_net_1;
assign HEARTBEAT_net_1            = HEARTBEAT_net_0;
assign HEARTBEAT                  = HEARTBEAT_net_1;
assign MASTER_ALARM_net_1         = MASTER_ALARM_net_0;
assign MASTER_ALARM               = MASTER_ALARM_net_1;
assign CRITICAL_ALARM_net_1       = CRITICAL_ALARM_net_0;
assign CRITICAL_ALARM             = CRITICAL_ALARM_net_1;
assign VOLT_DETECT_1P0_HIGH_net_1 = VOLT_DETECT_1P0_HIGH_net_0;
assign VOLT_DETECT_1P0_HIGH       = VOLT_DETECT_1P0_HIGH_net_1;
assign VOLT_DETECT_1P0_LOW_net_1  = VOLT_DETECT_1P0_LOW_net_0;
assign VOLT_DETECT_1P0_LOW        = VOLT_DETECT_1P0_LOW_net_1;
assign VOLT_DETECT_1P8_HIGH_net_1 = VOLT_DETECT_1P8_HIGH_net_0;
assign VOLT_DETECT_1P8_HIGH       = VOLT_DETECT_1P8_HIGH_net_1;
assign VOLT_DETECT_1P8_LOW_net_1  = VOLT_DETECT_1P8_LOW_net_0;
assign VOLT_DETECT_1P8_LOW        = VOLT_DETECT_1P8_LOW_net_1;
assign VOLT_DETECT_2P5_HIGH_net_1 = VOLT_DETECT_2P5_HIGH_net_0;
assign VOLT_DETECT_2P5_HIGH       = VOLT_DETECT_2P5_HIGH_net_1;
assign VOLT_DETECT_2P5_LOW_net_1  = VOLT_DETECT_2P5_LOW_net_0;
assign VOLT_DETECT_2P5_LOW        = VOLT_DETECT_2P5_LOW_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CORESMIP_PF   -   Actel:DirectCore:CORESMIP_PF:2.0.100
CORESMIP_PF #( 
        .ENABLE_FABRIC_PDC    ( 0 ),
        .ENABLE_SECURITY_PDC  ( 0 ),
        .ENABLE_SNVM_PDC      ( 0 ),
        .VDETECTOR_ENABLE_1P0 ( 1 ),
        .VDETECTOR_ENABLE_1P8 ( 0 ),
        .VDETECTOR_ENABLE_2P5 ( 0 ),
        .ZENABLE              ( 1 ),
        .ZMODE                ( 1 ) )
CORESMIP_PF_C0_0(
        // Inputs
        .CLK                        ( CLK ),
        .RESET_N                    ( RESET_N ),
        .CLEAR                      ( CLEAR ),
        .IO_DISABLE                 ( IO_DISABLE ),
        .LOCKDOWN                   ( LOCKDOWN ),
        .RESET_DEVICE               ( RESET_DEVICE ),
        .USER_ALARM                 ( USER_ALARM ),
        .DELAY_ZEROIZE_P            ( DELAY_ZEROIZE_P ),
        .DELAY_ZEROIZE_N            ( DELAY_ZEROIZE_N ),
        .ERASE_P                    ( ERASE_P ),
        .ERASE_N                    ( ERASE_N ),
        .VOLT_DETECT_1P0_HIGH_CLEAR ( VOLT_DETECT_1P0_HIGH_CLEAR ),
        .VOLT_DETECT_1P0_LOW_CLEAR  ( VOLT_DETECT_1P0_LOW_CLEAR ),
        .VOLT_DETECT_1P8_HIGH_CLEAR ( VOLT_DETECT_1P8_HIGH_CLEAR ),
        .VOLT_DETECT_1P8_LOW_CLEAR  ( VOLT_DETECT_1P8_LOW_CLEAR ),
        .VOLT_DETECT_2P5_HIGH_CLEAR ( VOLT_DETECT_2P5_HIGH_CLEAR ),
        .VOLT_DETECT_2P5_LOW_CLEAR  ( VOLT_DETECT_2P5_LOW_CLEAR ),
        // Outputs
        .FLAGS                      ( FLAGS_net_0 ),
        .RESET_REASON               ( RESET_REASON_net_0 ),
        .SLOW_CLOCK                 ( SLOW_CLOCK_net_0 ),
        .HEARTBEAT                  ( HEARTBEAT_net_0 ),
        .MASTER_ALARM               ( MASTER_ALARM_net_0 ),
        .CRITICAL_ALARM             ( CRITICAL_ALARM_net_0 ),
        .VOLT_DETECT_1P0_HIGH       ( VOLT_DETECT_1P0_HIGH_net_0 ),
        .VOLT_DETECT_1P0_LOW        ( VOLT_DETECT_1P0_LOW_net_0 ),
        .VOLT_DETECT_1P8_HIGH       ( VOLT_DETECT_1P8_HIGH_net_0 ),
        .VOLT_DETECT_1P8_LOW        ( VOLT_DETECT_1P8_LOW_net_0 ),
        .VOLT_DETECT_2P5_HIGH       ( VOLT_DETECT_2P5_HIGH_net_0 ),
        .VOLT_DETECT_2P5_LOW        ( VOLT_DETECT_2P5_LOW_net_0 ) 
        );


endmodule
