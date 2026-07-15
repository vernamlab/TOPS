(* keep_hierarchy = "yes" *)

`timescale 1ns / 1ps



module ring_oscillator
#(
	parameter N_STAGES = 3 
)(
	input  en,                 
	output osc_out          
	);

	
	(* S = "true" *)
	(* dont_touch = "true" *)
	reg [N_STAGES-1:0] b;

	
	generate
		genvar i;
		for (i = N_STAGES-1; i > 0; i = i-1) begin
			(* dont_touch = "true" *)
			always @(*) begin
				b[i] = ~b[i-1];
			end
		end
	endgenerate
	
	
	(* dont_touch = "true" *)
	always @(*) begin
		b[0] = ~b[N_STAGES-1] & en;     
	end
	
	
	assign osc_out = b[0];
    
endmodule
