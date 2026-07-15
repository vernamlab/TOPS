// **************************************************************************/ 
// Microsemi Corporation Proprietary and Confidential
// Copyright 2014 Microsemi Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED
// IN ADVANCE IN WRITING.
//
// Description:	CoreSMIP_PF
//
// SVN Revision Information:
// SVN $Revision: 22803 $
// SVN $Date: 2014-05-31 04:08:57 +0530 (Sat, 31 May 2014) $
//
// Notes:
//
// **************************************************************************/ 
module CORESMIP_PF ( 
    CLK                        , 
    RESET_N                    , 
    CLEAR                      , 
    IO_DISABLE                 , 
    LOCKDOWN                   , 
    RESET_DEVICE               , 
    USER_ALARM                 , 
    DELAY_ZEROIZE_P            , 
    DELAY_ZEROIZE_N            , 
    ERASE_P                    , 
    ERASE_N                    , 
    VOLT_DETECT_1P0_HIGH_CLEAR , 
    VOLT_DETECT_1P0_LOW_CLEAR  , 
    VOLT_DETECT_1P8_HIGH_CLEAR , 
    VOLT_DETECT_1P8_LOW_CLEAR  , 
    VOLT_DETECT_2P5_HIGH_CLEAR , 
    VOLT_DETECT_2P5_LOW_CLEAR  , 
    FLAGS                      , 
    RESET_REASON               , 
    SLOW_CLOCK                 , 
    HEARTBEAT                  , 
    MASTER_ALARM               , 
    CRITICAL_ALARM             , 
    VOLT_DETECT_1P0_HIGH       , 
    VOLT_DETECT_1P0_LOW        , 
    VOLT_DETECT_1P8_HIGH       , 
    VOLT_DETECT_1P8_LOW        , 
    VOLT_DETECT_2P5_HIGH       , 
    VOLT_DETECT_2P5_LOW          
) 
/* synthesis syn_hier = "hard" */ 
; 
parameter [0 : 0] ZENABLE             = 1'b1  ;
parameter [1 : 0] ZMODE               = 2'b01 ; 
parameter [0 : 0] ENABLE_FABRIC_PDC   = 1'b0  ; 
parameter [0 : 0] ENABLE_SNVM_PDC     = 1'b0  ; 
parameter [0 : 0] ENABLE_SECURITY_PDC = 1'b0  ; 
parameter [0 : 0] VDETECTOR_ENABLE_1P0 = 1'b0 ; 
parameter [0 : 0] VDETECTOR_ENABLE_1P8 = 1'b0 ; 
parameter [0 : 0] VDETECTOR_ENABLE_2P5 = 1'b0 ; 
localparam [15 : 0] PORDIGEST = {       4'b0001                 , 
                                  { 9 { ENABLE_SECURITY_PDC } } , 
                                  { 1 { ENABLE_SNVM_PDC     } } , 
                                  { 2 { ENABLE_FABRIC_PDC   } }   
                                } ; 
localparam [2 : 0] CLKMON_FREQ = 3'b000 ; 
input CLK ;
input RESET_N ;
input [31:0] CLEAR ;
input IO_DISABLE ;
input LOCKDOWN ;
input RESET_DEVICE ;
input USER_ALARM ;
input DELAY_ZEROIZE_P ;
input DELAY_ZEROIZE_N ;
input ERASE_P ;
input ERASE_N ;
input VOLT_DETECT_1P0_HIGH_CLEAR ;
input VOLT_DETECT_1P0_LOW_CLEAR ;
input VOLT_DETECT_1P8_HIGH_CLEAR ;
input VOLT_DETECT_1P8_LOW_CLEAR ;
input VOLT_DETECT_2P5_HIGH_CLEAR ;
input VOLT_DETECT_2P5_LOW_CLEAR ;
output [31:0] FLAGS ;
output [4:0] RESET_REASON ;
output SLOW_CLOCK ;
output HEARTBEAT ;
output MASTER_ALARM ;
output CRITICAL_ALARM ;
output VOLT_DETECT_1P0_HIGH ;
output VOLT_DETECT_1P0_LOW ;
output VOLT_DETECT_1P8_HIGH ;
output VOLT_DETECT_1P8_LOW ;
output VOLT_DETECT_2P5_HIGH ;
output VOLT_DETECT_2P5_LOW ;
wire CLK_c ;
wire RESET_N_c ;
wire [0:0] un1_DELAY_ZEROIZE_N_q4_Z;
wire [9:0] heartbeat_count_Z;
wire [9:0] wdog_count_Z;
wire [9:0] heartbeat_count_3_Z;
wire [9:0] wdog_count_3;
wire un1_wdog_count_10_cry_1_S ;
wire un1_wdog_count_10_cry_2_S ;
wire un1_wdog_count_10_cry_3_S ;
wire un1_wdog_count_10_cry_4_S ;
wire un1_wdog_count_10_cry_5_S ;
wire un1_wdog_count_10_cry_6_S ;
wire un1_wdog_count_10_cry_7_S ;
wire un1_wdog_count_10_cry_8_S ;
wire un1_wdog_count_10_s_9_S ;
wire zeroize_Z ;
wire DELAY_ZEROIZE_P_q4_Z ;
wire DELAY_ZEROIZE_N_q2_Z ;
wire ERASE_N_q2_Z ;
wire VCC ;
wire GND ;
wire RESET_N_q1_Z ;
wire MASTER_ALARM_q2_Z ;
wire MASTER_ALARM_q1_Z ;
wire CRITICAL_ALARM_q2_Z ;
wire CRITICAL_ALARM_q1_Z ;
wire USER_ALARM_q1_Z ;
wire DELAY_ZEROIZE_P_q1_Z ;
wire DELAY_ZEROIZE_N_q1_Z ;
wire ERASE_P_q1_Z ;
wire ERASE_N_q1_Z ;
wire USER_ALARM_r_Z ;
wire DELAY_ZEROIZE_N_q4_Z ;
wire DELAY_ZEROIZE_N_q3_Z ;
wire DELAY_ZEROIZE_P_q2_Z ;
wire DELAY_ZEROIZE_P_q3_Z ;
wire USER_ALARM_q2_Z ;
wire ERASE_P_q2_Z ;
wire wdog_timeout_Z ;
wire RESET_N_q2_Z ;
wire HEARTBEAT_0_Z ;
wire wdog_count12_Z ;
wire wdog_timeout4_Z ;
wire N_29_mux ;
wire un3_heartbeat_count_1_cry_1_S ;
wire un3_heartbeat_count_1_cry_2_S ;
wire un3_heartbeat_count_1_cry_3_S ;
wire un3_heartbeat_count_1_cry_4_S ;
wire un3_heartbeat_count_1_cry_5_S ;
wire un3_heartbeat_count_1_cry_6_S ;
wire un3_heartbeat_count_1_cry_7_S ;
wire un3_heartbeat_count_1_cry_8_S ;
wire un3_heartbeat_count_1_s_9_S ;
wire un3_heartbeat_count_1_cry_1_Z ;
wire un3_heartbeat_count_1_cry_2_Z ;
wire un3_heartbeat_count_1_cry_3_Z ;
wire un3_heartbeat_count_1_cry_4_Z ;
wire un3_heartbeat_count_1_cry_5_Z ;
wire un3_heartbeat_count_1_cry_6_Z ;
wire un3_heartbeat_count_1_cry_7_Z ;
wire un3_heartbeat_count_1_cry_8_Z ;
wire un1_wdog_count_10_cry_0_Z ;
wire un1_wdog_count_10_cry_1_Z ;
wire un1_wdog_count_10_cry_2_Z ;
wire un1_wdog_count_10_cry_3_Z ;
wire un1_wdog_count_10_cry_4_Z ;
wire un1_wdog_count_10_cry_5_Z ;
wire un1_wdog_count_10_cry_6_Z ;
wire un1_wdog_count_10_cry_7_Z ;
wire un1_wdog_count_10_cry_8_Z ;
wire zeroize_0_1_Z ;
wire m8_6 ;
wire m8_7 ;
wire m8_8 ;
wire wdog_timeout4_5_Z ;
wire wdog_timeout4_6_Z ;
wire HEARTBEAT4_3_Z ;
wire HEARTBEAT4_4_Z ;
wire HEARTBEAT4_5_Z ;
wire m20_10 ;
wire m20_11 ;
wire m20_12 ;
wire m20_13 ;
wire m20_14 ;
wire m20_17 ;
wire N_40_mux_i ;
wire CRITICAL_ALARM_fast_Z ;
wire USER_ALARM_r_fast_Z ;
wire un3_heartbeat_count_1_s_1_31_FCO ;
wire un3_heartbeat_count_1_cry_8_Y ;
wire un3_heartbeat_count_1_s_9_FCO ;
wire un3_heartbeat_count_1_s_9_Y ;
wire un3_heartbeat_count_1_cry_7_Y ;
wire un3_heartbeat_count_1_cry_6_Y ;
wire un3_heartbeat_count_1_cry_5_Y ;
wire un3_heartbeat_count_1_cry_4_Y ;
wire un3_heartbeat_count_1_cry_3_Y ;
wire un3_heartbeat_count_1_cry_2_Y ;
wire un3_heartbeat_count_1_cry_1_Y ;
wire un3_heartbeat_count_1_s_1_31_S ;
wire un3_heartbeat_count_1_s_1_31_Y ;
wire un1_wdog_count_10_cry_8_Y ;
wire un1_wdog_count_10_s_9_FCO ;
wire un1_wdog_count_10_s_9_Y ;
wire un1_wdog_count_10_cry_7_Y ;
wire un1_wdog_count_10_cry_6_Y ;
wire un1_wdog_count_10_cry_5_Y ;
wire un1_wdog_count_10_cry_4_Y ;
wire un1_wdog_count_10_cry_3_Y ;
wire un1_wdog_count_10_cry_2_Y ;
wire un1_wdog_count_10_cry_1_Y ;
wire un1_wdog_count_10_cry_0_S ;
wire un1_wdog_count_10_cry_0_Y ;
// @5:90
  CLKINT CLK_buf (
	.Y(CLK_c),
	.A(CLK)
);
// @5:91
  BUFD RESET_N_bufd (
	.Y(RESET_N_c),
	.A(RESET_N)
);
// @5:183
  SLE \heartbeat_count[7]  (
	.Q(heartbeat_count_Z[7]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[7]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[8]  (
	.Q(heartbeat_count_Z[8]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[8]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[9]  (
	.Q(heartbeat_count_Z[9]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[9]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[2]  (
	.Q(wdog_count_Z[2]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[2]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[3]  (
	.Q(wdog_count_Z[3]),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[3]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[4]  (
	.Q(wdog_count_Z[4]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[4]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[5]  (
	.Q(wdog_count_Z[5]),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[5]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[6]  (
	.Q(wdog_count_Z[6]),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[6]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[7]  (
	.Q(wdog_count_Z[7]),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[7]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[8]  (
	.Q(wdog_count_Z[8]),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[8]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[9]  (
	.Q(wdog_count_Z[9]),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[9]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[0]  (
	.Q(heartbeat_count_Z[0]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[0]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[1]  (
	.Q(heartbeat_count_Z[1]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(un3_heartbeat_count_1_cry_1_S),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[2]  (
	.Q(heartbeat_count_Z[2]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(un3_heartbeat_count_1_cry_2_S),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[3]  (
	.Q(heartbeat_count_Z[3]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[3]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[4]  (
	.Q(heartbeat_count_Z[4]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(un3_heartbeat_count_1_cry_4_S),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[5]  (
	.Q(heartbeat_count_Z[5]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[5]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:183
  SLE \heartbeat_count[6]  (
	.Q(heartbeat_count_Z[6]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(heartbeat_count_3_Z[6]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:399
  SLE wdog_timeout (
	.Q(wdog_timeout_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(wdog_timeout4_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:189
  SLE HEARTBEAT_Z (
	.Q(HEARTBEAT),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(HEARTBEAT_0_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:405
  SLE zeroize (
	.Q(zeroize_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(zeroize_0_1_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:284
  SLE USER_ALARM_r (
	.Q(USER_ALARM_r_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(USER_ALARM_q2_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:267
  SLE CRITICAL_ALARM_Z (
	.Q(CRITICAL_ALARM),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(CRITICAL_ALARM_q2_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:248
  SLE MASTER_ALARM_Z (
	.Q(MASTER_ALARM),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(MASTER_ALARM_q2_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[0]  (
	.Q(wdog_count_Z[0]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[0]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:391
  SLE \wdog_count[1]  (
	.Q(wdog_count_Z[1]),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(wdog_count_3[1]),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:256
  SLE CRITICAL_ALARM_q1 (
	.Q(CRITICAL_ALARM_q1_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(N_29_mux),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:277
  SLE USER_ALARM_q2 (
	.Q(USER_ALARM_q2_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(USER_ALARM_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:294
  SLE DELAY_ZEROIZE_P_q2 (
	.Q(DELAY_ZEROIZE_P_q2_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_P_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:317
  SLE DELAY_ZEROIZE_N_q2 (
	.Q(DELAY_ZEROIZE_N_q2_Z),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_N_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:340
  SLE ERASE_P_q2 (
	.Q(ERASE_P_q2_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(ERASE_P_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:350
  SLE ERASE_N_q2 (
	.Q(ERASE_N_q2_Z),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(ERASE_N_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:298
  SLE DELAY_ZEROIZE_P_q3 (
	.Q(DELAY_ZEROIZE_P_q3_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_P_q2_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:321
  SLE DELAY_ZEROIZE_N_q3 (
	.Q(DELAY_ZEROIZE_N_q3_Z),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_N_q2_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:302
  SLE DELAY_ZEROIZE_P_q4 (
	.Q(DELAY_ZEROIZE_P_q4_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_P_q3_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:325
  SLE DELAY_ZEROIZE_N_q4 (
	.Q(DELAY_ZEROIZE_N_q4_Z),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_N_q3_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:238
  SLE MASTER_ALARM_q1 (
	.Q(MASTER_ALARM_q1_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(N_40_mux_i),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:177
  SLE RESET_N_q2 (
	.Q(RESET_N_q2_Z),
	.ADn(VCC),
	.ALn(RESET_N_c),
	.CLK(CLK_c),
	.D(RESET_N_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:242
  SLE MASTER_ALARM_q2 (
	.Q(MASTER_ALARM_q2_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(MASTER_ALARM_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:260
  SLE CRITICAL_ALARM_q2 (
	.Q(CRITICAL_ALARM_q2_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(CRITICAL_ALARM_q1_Z),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:273
  SLE USER_ALARM_q1 (
	.Q(USER_ALARM_q1_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(USER_ALARM),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:290
  SLE DELAY_ZEROIZE_P_q1 (
	.Q(DELAY_ZEROIZE_P_q1_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_P),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:313
  SLE DELAY_ZEROIZE_N_q1 (
	.Q(DELAY_ZEROIZE_N_q1_Z),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(DELAY_ZEROIZE_N),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:336
  SLE ERASE_P_q1 (
	.Q(ERASE_P_q1_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(ERASE_P),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:346
  SLE ERASE_N_q1 (
	.Q(ERASE_N_q1_Z),
	.ADn(GND),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(ERASE_N),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:173
  SLE RESET_N_q1 (
	.Q(RESET_N_q1_Z),
	.ADn(VCC),
	.ALn(RESET_N_c),
	.CLK(CLK_c),
	.D(VCC),
	.EN(VCC),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:267
  SLE CRITICAL_ALARM_fast (
	.Q(CRITICAL_ALARM_fast_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(CRITICAL_ALARM_q2_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:284
  SLE USER_ALARM_r_fast (
	.Q(USER_ALARM_r_fast_Z),
	.ADn(VCC),
	.ALn(RESET_N_q2_Z),
	.CLK(CLK_c),
	.D(VCC),
	.EN(USER_ALARM_q2_Z),
	.LAT(GND),
	.SD(GND),
	.SLn(VCC)
);
// @5:395
  ARI1 un1_wdog_count_10_cry_0 (
	.FCO(un1_wdog_count_10_cry_0_Z),
	.S(un1_wdog_count_10_cry_0_S),
	.Y(un1_wdog_count_10_cry_0_Y),
	.B(CRITICAL_ALARM),
	.C(USER_ALARM_r_Z),
	.D(GND),
	.A(wdog_count_Z[0]),
	.FCI(GND)
);
defparam un1_wdog_count_10_cry_0.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_1 (
	.FCO(un1_wdog_count_10_cry_1_Z),
	.S(un1_wdog_count_10_cry_1_S),
	.Y(un1_wdog_count_10_cry_1_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[1]),
	.FCI(un1_wdog_count_10_cry_0_Z)
);
defparam un1_wdog_count_10_cry_1.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_2 (
	.FCO(un1_wdog_count_10_cry_2_Z),
	.S(un1_wdog_count_10_cry_2_S),
	.Y(un1_wdog_count_10_cry_2_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[2]),
	.FCI(un1_wdog_count_10_cry_1_Z)
);
defparam un1_wdog_count_10_cry_2.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_3 (
	.FCO(un1_wdog_count_10_cry_3_Z),
	.S(un1_wdog_count_10_cry_3_S),
	.Y(un1_wdog_count_10_cry_3_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[3]),
	.FCI(un1_wdog_count_10_cry_2_Z)
);
defparam un1_wdog_count_10_cry_3.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_4 (
	.FCO(un1_wdog_count_10_cry_4_Z),
	.S(un1_wdog_count_10_cry_4_S),
	.Y(un1_wdog_count_10_cry_4_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[4]),
	.FCI(un1_wdog_count_10_cry_3_Z)
);
defparam un1_wdog_count_10_cry_4.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_5 (
	.FCO(un1_wdog_count_10_cry_5_Z),
	.S(un1_wdog_count_10_cry_5_S),
	.Y(un1_wdog_count_10_cry_5_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[5]),
	.FCI(un1_wdog_count_10_cry_4_Z)
);
defparam un1_wdog_count_10_cry_5.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_6 (
	.FCO(un1_wdog_count_10_cry_6_Z),
	.S(un1_wdog_count_10_cry_6_S),
	.Y(un1_wdog_count_10_cry_6_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[6]),
	.FCI(un1_wdog_count_10_cry_5_Z)
);
defparam un1_wdog_count_10_cry_6.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_cry_7 (
	.FCO(un1_wdog_count_10_cry_7_Z),
	.S(un1_wdog_count_10_cry_7_S),
	.Y(un1_wdog_count_10_cry_7_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[7]),
	.FCI(un1_wdog_count_10_cry_6_Z)
);
defparam un1_wdog_count_10_cry_7.INIT=20'h511EE;
// @5:395
  ARI1 un1_wdog_count_10_s_9 (
	.FCO(un1_wdog_count_10_s_9_FCO),
	.S(un1_wdog_count_10_s_9_S),
	.Y(un1_wdog_count_10_s_9_Y),
	.B(CRITICAL_ALARM),
	.C(USER_ALARM_r_Z),
	.D(wdog_count_Z[9]),
	.A(VCC),
	.FCI(un1_wdog_count_10_cry_8_Z)
);
defparam un1_wdog_count_10_s_9.INIT=20'h41E00;
// @5:395
  ARI1 un1_wdog_count_10_cry_8 (
	.FCO(un1_wdog_count_10_cry_8_Z),
	.S(un1_wdog_count_10_cry_8_S),
	.Y(un1_wdog_count_10_cry_8_Y),
	.B(CRITICAL_ALARM_fast_Z),
	.C(USER_ALARM_r_fast_Z),
	.D(GND),
	.A(wdog_count_Z[8]),
	.FCI(un1_wdog_count_10_cry_7_Z)
);
defparam un1_wdog_count_10_cry_8.INIT=20'h511EE;
// @5:186
  ARI1 un3_heartbeat_count_1_s_1_31 (
	.FCO(un3_heartbeat_count_1_s_1_31_FCO),
	.S(un3_heartbeat_count_1_s_1_31_S),
	.Y(un3_heartbeat_count_1_s_1_31_Y),
	.B(heartbeat_count_Z[0]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(VCC)
);
defparam un3_heartbeat_count_1_s_1_31.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_1 (
	.FCO(un3_heartbeat_count_1_cry_1_Z),
	.S(un3_heartbeat_count_1_cry_1_S),
	.Y(un3_heartbeat_count_1_cry_1_Y),
	.B(heartbeat_count_Z[1]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_s_1_31_FCO)
);
defparam un3_heartbeat_count_1_cry_1.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_2 (
	.FCO(un3_heartbeat_count_1_cry_2_Z),
	.S(un3_heartbeat_count_1_cry_2_S),
	.Y(un3_heartbeat_count_1_cry_2_Y),
	.B(heartbeat_count_Z[2]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_1_Z)
);
defparam un3_heartbeat_count_1_cry_2.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_3 (
	.FCO(un3_heartbeat_count_1_cry_3_Z),
	.S(un3_heartbeat_count_1_cry_3_S),
	.Y(un3_heartbeat_count_1_cry_3_Y),
	.B(heartbeat_count_Z[3]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_2_Z)
);
defparam un3_heartbeat_count_1_cry_3.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_4 (
	.FCO(un3_heartbeat_count_1_cry_4_Z),
	.S(un3_heartbeat_count_1_cry_4_S),
	.Y(un3_heartbeat_count_1_cry_4_Y),
	.B(heartbeat_count_Z[4]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_3_Z)
);
defparam un3_heartbeat_count_1_cry_4.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_5 (
	.FCO(un3_heartbeat_count_1_cry_5_Z),
	.S(un3_heartbeat_count_1_cry_5_S),
	.Y(un3_heartbeat_count_1_cry_5_Y),
	.B(heartbeat_count_Z[5]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_4_Z)
);
defparam un3_heartbeat_count_1_cry_5.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_6 (
	.FCO(un3_heartbeat_count_1_cry_6_Z),
	.S(un3_heartbeat_count_1_cry_6_S),
	.Y(un3_heartbeat_count_1_cry_6_Y),
	.B(heartbeat_count_Z[6]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_5_Z)
);
defparam un3_heartbeat_count_1_cry_6.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_7 (
	.FCO(un3_heartbeat_count_1_cry_7_Z),
	.S(un3_heartbeat_count_1_cry_7_S),
	.Y(un3_heartbeat_count_1_cry_7_Y),
	.B(heartbeat_count_Z[7]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_6_Z)
);
defparam un3_heartbeat_count_1_cry_7.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_s_9 (
	.FCO(un3_heartbeat_count_1_s_9_FCO),
	.S(un3_heartbeat_count_1_s_9_S),
	.Y(un3_heartbeat_count_1_s_9_Y),
	.B(heartbeat_count_Z[9]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_8_Z)
);
defparam un3_heartbeat_count_1_s_9.INIT=20'h4AA00;
// @5:186
  ARI1 un3_heartbeat_count_1_cry_8 (
	.FCO(un3_heartbeat_count_1_cry_8_Z),
	.S(un3_heartbeat_count_1_cry_8_S),
	.Y(un3_heartbeat_count_1_cry_8_Y),
	.B(heartbeat_count_Z[8]),
	.C(GND),
	.D(GND),
	.A(VCC),
	.FCI(un3_heartbeat_count_1_cry_7_Z)
);
defparam un3_heartbeat_count_1_cry_8.INIT=20'h4AA00;
// @5:185
  CFG2 HEARTBEAT4_3 (
	.A(heartbeat_count_Z[2]),
	.B(heartbeat_count_Z[4]),
	.Y(HEARTBEAT4_3_Z)
);
defparam HEARTBEAT4_3.INIT=4'h1;
// @5:267
  CFG3 \un1_DELAY_ZEROIZE_N_q4[0]  (
	.A(DELAY_ZEROIZE_N_q4_Z),
	.B(DELAY_ZEROIZE_N_q3_Z),
	.C(DELAY_ZEROIZE_N_q2_Z),
	.Y(un1_DELAY_ZEROIZE_N_q4_Z[0])
);
defparam \un1_DELAY_ZEROIZE_N_q4[0] .INIT=8'h2E;
  CFG4 MASTER_ALARM_q1_RNO_3 (
	.A(FLAGS[15]),
	.B(FLAGS[14]),
	.C(FLAGS[5]),
	.D(FLAGS[4]),
	.Y(m20_14)
);
defparam MASTER_ALARM_q1_RNO_3.INIT=16'h0001;
  CFG4 MASTER_ALARM_q1_RNO_1 (
	.A(FLAGS[31]),
	.B(FLAGS[30]),
	.C(FLAGS[17]),
	.D(FLAGS[16]),
	.Y(m20_13)
);
defparam MASTER_ALARM_q1_RNO_1.INIT=16'h0001;
  CFG4 MASTER_ALARM_q1_RNO_2 (
	.A(FLAGS[23]),
	.B(FLAGS[22]),
	.C(FLAGS[21]),
	.D(FLAGS[20]),
	.Y(m20_12)
);
defparam MASTER_ALARM_q1_RNO_2.INIT=16'h0001;
  CFG4 MASTER_ALARM_q1_RNO_4 (
	.A(FLAGS[24]),
	.B(FLAGS[19]),
	.C(FLAGS[6]),
	.D(FLAGS[0]),
	.Y(m20_11)
);
defparam MASTER_ALARM_q1_RNO_4.INIT=16'h0001;
  CFG4 MASTER_ALARM_q1_RNO_5 (
	.A(FLAGS[29]),
	.B(FLAGS[26]),
	.C(FLAGS[3]),
	.D(FLAGS[2]),
	.Y(m20_10)
);
defparam MASTER_ALARM_q1_RNO_5.INIT=16'h0001;
// @5:185
  CFG4 HEARTBEAT4_5 (
	.A(heartbeat_count_Z[7]),
	.B(heartbeat_count_Z[6]),
	.C(heartbeat_count_Z[5]),
	.D(heartbeat_count_Z[3]),
	.Y(HEARTBEAT4_5_Z)
);
defparam HEARTBEAT4_5.INIT=16'h8000;
// @5:185
  CFG3 HEARTBEAT4_4 (
	.A(heartbeat_count_Z[9]),
	.B(heartbeat_count_Z[8]),
	.C(heartbeat_count_Z[1]),
	.Y(HEARTBEAT4_4_Z)
);
defparam HEARTBEAT4_4.INIT=8'h08;
// @5:394
  CFG4 wdog_timeout4_6 (
	.A(wdog_count_Z[6]),
	.B(wdog_count_Z[3]),
	.C(wdog_count_Z[2]),
	.D(wdog_count_Z[1]),
	.Y(wdog_timeout4_6_Z)
);
defparam wdog_timeout4_6.INIT=16'h0001;
// @5:394
  CFG4 wdog_timeout4_5 (
	.A(wdog_count_Z[9]),
	.B(wdog_count_Z[8]),
	.C(wdog_count_Z[5]),
	.D(wdog_count_Z[4]),
	.Y(wdog_timeout4_5_Z)
);
defparam wdog_timeout4_5.INIT=16'h0001;
  CFG4 TAMPER_MACRO_RNI83MT (
	.A(FLAGS[25]),
	.B(FLAGS[18]),
	.C(FLAGS[7]),
	.D(FLAGS[1]),
	.Y(m8_8)
);
defparam TAMPER_MACRO_RNI83MT.INIT=16'h0001;
  CFG4 TAMPER_MACRO_RNI83MT_0 (
	.A(FLAGS[28]),
	.B(FLAGS[27]),
	.C(FLAGS[9]),
	.D(FLAGS[8]),
	.Y(m8_7)
);
defparam TAMPER_MACRO_RNI83MT_0.INIT=16'h0001;
  CFG4 TAMPER_MACRO_RNI83MT_1 (
	.A(FLAGS[13]),
	.B(FLAGS[12]),
	.C(FLAGS[11]),
	.D(FLAGS[10]),
	.Y(m8_6)
);
defparam TAMPER_MACRO_RNI83MT_1.INIT=16'h0001;
// @5:405
  CFG3 zeroize_0_1 (
	.A(wdog_timeout_Z),
	.B(ERASE_P_q2_Z),
	.C(ERASE_N_q2_Z),
	.Y(zeroize_0_1_Z)
);
defparam zeroize_0_1.INIT=8'hEF;
// @5:392
  CFG3 \wdog_count_RNO[4]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_4_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[4])
);
defparam \wdog_count_RNO[4] .INIT=8'h04;
// @5:392
  CFG3 \wdog_count_RNO[2]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_2_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[2])
);
defparam \wdog_count_RNO[2] .INIT=8'h04;
// @5:392
  CFG3 \wdog_count_RNO[1]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_1_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[1])
);
defparam \wdog_count_RNO[1] .INIT=8'h04;
// @5:392
  CFG3 \wdog_count_3_iv[3]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_3_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[3])
);
defparam \wdog_count_3_iv[3] .INIT=8'hF4;
// @5:392
  CFG3 \wdog_count_3_iv[5]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_5_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[5])
);
defparam \wdog_count_3_iv[5] .INIT=8'hF4;
// @5:392
  CFG3 \wdog_count_3_iv[6]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_6_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[6])
);
defparam \wdog_count_3_iv[6] .INIT=8'hF4;
// @5:392
  CFG3 \wdog_count_3_iv[7]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_7_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[7])
);
defparam \wdog_count_3_iv[7] .INIT=8'hF4;
// @5:392
  CFG3 \wdog_count_3_iv[8]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_cry_8_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[8])
);
defparam \wdog_count_3_iv[8] .INIT=8'hF4;
// @5:392
  CFG3 \wdog_count_3_iv[9]  (
	.A(wdog_timeout4_Z),
	.B(un1_wdog_count_10_s_9_S),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[9])
);
defparam \wdog_count_3_iv[9] .INIT=8'hF4;
// @5:393
  CFG4 wdog_count12 (
	.A(DELAY_ZEROIZE_P_q2_Z),
	.B(un1_DELAY_ZEROIZE_N_q4_Z[0]),
	.C(DELAY_ZEROIZE_P_q4_Z),
	.D(DELAY_ZEROIZE_P_q3_Z),
	.Y(wdog_count12_Z)
);
defparam wdog_count12.INIT=16'h0C88;
// @5:392
  CFG3 \wdog_count_RNO[0]  (
	.A(un1_wdog_count_10_cry_0_Y),
	.B(wdog_timeout4_Z),
	.C(wdog_count12_Z),
	.Y(wdog_count_3[0])
);
defparam \wdog_count_RNO[0] .INIT=8'h02;
  CFG3 MASTER_ALARM_q1_RNO_0 (
	.A(m20_14),
	.B(m20_11),
	.C(m20_10),
	.Y(m20_17)
);
defparam MASTER_ALARM_q1_RNO_0.INIT=8'h80;
  CFG3 TAMPER_MACRO_RNIO92P2 (
	.A(m8_8),
	.B(m8_7),
	.C(m8_6),
	.Y(N_29_mux)
);
defparam TAMPER_MACRO_RNIO92P2.INIT=8'h7F;
// @5:394
  CFG4 wdog_timeout4 (
	.A(wdog_count_Z[7]),
	.B(wdog_count_Z[0]),
	.C(wdog_timeout4_6_Z),
	.D(wdog_timeout4_5_Z),
	.Y(wdog_timeout4_Z)
);
defparam wdog_timeout4.INIT=16'h1000;
// @5:189
  CFG4 HEARTBEAT_0 (
	.A(HEARTBEAT4_3_Z),
	.B(HEARTBEAT4_4_Z),
	.C(HEARTBEAT4_5_Z),
	.D(HEARTBEAT),
	.Y(HEARTBEAT_0_Z)
);
defparam HEARTBEAT_0.INIT=16'h7F80;
// @5:184
  CFG4 \heartbeat_count_3[9]  (
	.A(HEARTBEAT4_3_Z),
	.B(HEARTBEAT4_4_Z),
	.C(HEARTBEAT4_5_Z),
	.D(un3_heartbeat_count_1_s_9_S),
	.Y(heartbeat_count_3_Z[9])
);
defparam \heartbeat_count_3[9] .INIT=16'h7F00;
// @5:184
  CFG4 \heartbeat_count_3[8]  (
	.A(HEARTBEAT4_3_Z),
	.B(HEARTBEAT4_4_Z),
	.C(HEARTBEAT4_5_Z),
	.D(un3_heartbeat_count_1_cry_8_S),
	.Y(heartbeat_count_3_Z[8])
);
defparam \heartbeat_count_3[8] .INIT=16'h7F00;
// @5:184
  CFG4 \heartbeat_count_3[7]  (
	.A(HEARTBEAT4_4_Z),
	.B(HEARTBEAT4_3_Z),
	.C(HEARTBEAT4_5_Z),
	.D(un3_heartbeat_count_1_cry_7_S),
	.Y(heartbeat_count_3_Z[7])
);
defparam \heartbeat_count_3[7] .INIT=16'h7F00;
// @5:184
  CFG4 \heartbeat_count_3[6]  (
	.A(HEARTBEAT4_4_Z),
	.B(HEARTBEAT4_3_Z),
	.C(HEARTBEAT4_5_Z),
	.D(un3_heartbeat_count_1_cry_6_S),
	.Y(heartbeat_count_3_Z[6])
);
defparam \heartbeat_count_3[6] .INIT=16'h7F00;
// @5:184
  CFG4 \heartbeat_count_3[5]  (
	.A(HEARTBEAT4_4_Z),
	.B(HEARTBEAT4_3_Z),
	.C(HEARTBEAT4_5_Z),
	.D(un3_heartbeat_count_1_cry_5_S),
	.Y(heartbeat_count_3_Z[5])
);
defparam \heartbeat_count_3[5] .INIT=16'h7F00;
// @5:184
  CFG4 \heartbeat_count_3[3]  (
	.A(HEARTBEAT4_4_Z),
	.B(HEARTBEAT4_3_Z),
	.C(HEARTBEAT4_5_Z),
	.D(un3_heartbeat_count_1_cry_3_S),
	.Y(heartbeat_count_3_Z[3])
);
defparam \heartbeat_count_3[3] .INIT=16'h7F00;
// @5:184
  CFG4 \heartbeat_count_3[0]  (
	.A(HEARTBEAT4_4_Z),
	.B(HEARTBEAT4_5_Z),
	.C(heartbeat_count_Z[0]),
	.D(HEARTBEAT4_3_Z),
	.Y(heartbeat_count_3_Z[0])
);
defparam \heartbeat_count_3[0] .INIT=16'h070F;
// @5:238
  CFG4 MASTER_ALARM_q1_RNO (
	.A(N_29_mux),
	.B(m20_17),
	.C(m20_13),
	.D(m20_12),
	.Y(N_40_mux_i)
);
defparam MASTER_ALARM_q1_RNO.INIT=16'hBFFF;
// @5:445
  VOLTAGEDETECT VOLTAGEDETECT_MACRO (
	.VOLT_DETECT_1P0_HIGH_CLEAR(VOLT_DETECT_1P0_HIGH_CLEAR),
	.VOLT_DETECT_1P0_LOW_CLEAR(VOLT_DETECT_1P0_LOW_CLEAR),
	.VOLT_DETECT_1P8_HIGH_CLEAR(VOLT_DETECT_1P8_HIGH_CLEAR),
	.VOLT_DETECT_1P8_LOW_CLEAR(VOLT_DETECT_1P8_LOW_CLEAR),
	.VOLT_DETECT_2P5_HIGH_CLEAR(VOLT_DETECT_2P5_HIGH_CLEAR),
	.VOLT_DETECT_2P5_LOW_CLEAR(VOLT_DETECT_2P5_LOW_CLEAR),
	.VOLT_DETECT_1P0_HIGH(VOLT_DETECT_1P0_HIGH),
	.VOLT_DETECT_1P0_LOW(VOLT_DETECT_1P0_LOW),
	.VOLT_DETECT_1P8_HIGH(VOLT_DETECT_1P8_HIGH),
	.VOLT_DETECT_1P8_LOW(VOLT_DETECT_1P8_LOW),
	.VOLT_DETECT_2P5_HIGH(VOLT_DETECT_2P5_HIGH),
	.VOLT_DETECT_2P5_LOW(VOLT_DETECT_2P5_LOW)
);
defparam VOLTAGEDETECT_MACRO.VDETECTOR_ENABLE_1P0=VDETECTOR_ENABLE_1P0;
defparam VOLTAGEDETECT_MACRO.VDETECTOR_ENABLE_1P8=VDETECTOR_ENABLE_1P8;
defparam VOLTAGEDETECT_MACRO.VDETECTOR_ENABLE_2P5=VDETECTOR_ENABLE_2P5;
// @5:424
  TAMPER TAMPER_MACRO (
	.CLEAR(CLEAR),
	.IO_DISABLE(IO_DISABLE),
	.LOCKDOWN(LOCKDOWN),
	.RESET_DEVICE(RESET_DEVICE),
	.ZEROIZE(zeroize_Z && ZENABLE),
	.FLAGS(FLAGS),
	.RESET_REASON(RESET_REASON),
	.SLOW_CLOCK(SLOW_CLOCK)
);
defparam TAMPER_MACRO.ZMODE=ZMODE;
defparam TAMPER_MACRO.PORDIGEST=PORDIGEST;
defparam TAMPER_MACRO.CLKMON_FREQ=CLKMON_FREQ;
  GND GND_Z (
	.Y(GND)
);
  VCC VCC_Z (
	.Y(VCC)
);
endmodule 
