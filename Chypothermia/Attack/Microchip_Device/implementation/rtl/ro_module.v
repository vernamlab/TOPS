
module ro_module #(
	parameter N_STAGES = 11)(
	input  en,              // active high enable   
	output ro_out          // ring oscillator output
	);

	// output of each inverter
    (* syn_noprune = 1 *)
    (* syn_preserve = 1, syn_keep = 1, DONT_TOUCH = "true" *)
	reg [N_STAGES-1:0] b;

	// generate n stages feeding into each other
	generate
		genvar i;
		for (i = N_STAGES-1; i > 0; i = i-1) begin
			(* dont_touch = "true" *)
			always @(*) begin
				b[i] = ~b[i-1];
			end
		end
	endgenerate
	
	// first stage feeds into last
	(* dont_touch = "true" *)
	always @(*) begin
		b[0] = ~b[N_STAGES-1] & en;
	end
	
	// output is just one of those stages
	assign ro_out = b[0];

endmodule

