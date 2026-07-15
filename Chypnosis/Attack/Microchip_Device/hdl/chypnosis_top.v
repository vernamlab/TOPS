/*
	chypnosis_top.v

	top-level module for cleaner version of chypnosis experiments
	
	Author: [redacted]
	Created 10 Jun 2025
 */

module chypnosis_top(
	input        clk,
	input  [4:0] DIP,
	input        SWITCH1,
	input        SWITCH2,
	output       heartbeat, // SEG_DSP_IO2
	output [6:0] LED
	);


	// alarm signals
	wire        vl; // VDD low
	wire        vh; // VDD high
	wire        sc; // slow clock
	wire        ma; // master alarm (OR of all flags)
	wire        ca; // critical alarm (OR of critical flags)
	wire [31:0] f;  // tamper flags


	// counter for verifying hibernation does happen 
	reg [30:0] count = 0;
	always @(posedge clk) count <= count + 1;


	// registers to verify low voltage alarms
	reg sc_reg; // slow clock
	reg vl_reg; // VDD low

	always @(posedge clk) begin
		
		// reset both with switch1
		if (~SWITCH1) begin
			sc_reg <= 1'b0;
			vl_reg <= 1'b0;
		end

		// set each with their respective alarm signals, only once
		else begin
			if (sc) begin
				sc_reg <= 1'b1;
			end
			if (vl) begin
				vl_reg <= 1'b1;
			end
		end
	end


	// first four switches used to set LEDs
	wire [3:0] sel;
	assign sel = DIP[3:0];
	
	// set LEDs based on switches
	assign LED = (sel == 4'd0)  ? {ma, ca, 1'b0, f[3:0]}   :         // flags
	             (sel == 4'd1)  ? {ma, ca, 1'b0, f[7:4]}   :
	             (sel == 4'd2)  ? {ma, ca, 1'b0, f[11:8]}  :         // 11: LOCK_ERROR always on
	             (sel == 4'd3)  ? {ma, ca, 1'b0, f[15:12]} :
	             (sel == 4'd4)  ? {ma, ca, 1'b0, f[19:16]} :
	             (sel == 4'd5)  ? {ma, ca, 1'b0, f[23:20]} :
	             (sel == 4'd6)  ? {ma, ca, 1'b0, f[27:24]} :
	             (sel == 4'd7)  ? {ma, ca, 1'b0, f[31:28]} :
	             (sel == 4'd8)  ? {ma, ca, sc, vh, vl, sc_reg, vl_reg} : // voltage sensors
	            //  (sel == 4'd9)  ? {sc_reg, vl_reg}           : // alarm registers
	             (sel == 4'd10)  ? count[29:24]      :   // counter
			                     7'b0000000;

	// CoreSMIP_PF wrapper
	tamperGuy t0(
		.clk                 (clk),                  // clock
		.rst_n               (SWITCH2 ),             // active-low reset
		.clr                 (~SWITCH1),             // active-high clear
		.zeroize             ((DIP[4]) & (sc | vl)), // active-high zeroize
		.MASTER_ALARM        (ma),                   // master alarm
		.CRITICAL_ALARM      (ca),                   // critical alarm
		.SLOW_CLOCK          (sc),                   // slow clock alarm
		.VOLT_DETECT_1P0_LOW (vl),                   // low voltage alarm
		.VOLT_DETECT_1P0_HIGH(vh),                   // high voltage alarm
		.HEARTBEAT           (heartbeat),            // heartbeat output
		.flags               (f)                     // alarm flags
	);

endmodule