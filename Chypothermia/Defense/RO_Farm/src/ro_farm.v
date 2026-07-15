(* keep_hierarchy = "yes" *)

module ro_farm #(
  parameter integer NUM_RO = 5200
) (
  input  wire en,
  output wire farm_out
);
  (* KEEP="true", DONT_TOUCH="true" *) wire [NUM_RO-1:0] ro_bus;

  genvar i;
  generate
    for (i = 0; i < NUM_RO; i = i + 1) begin : GEN_RO
      
      (* DONT_TOUCH="true" *)
      ring_oscillator ro_inst (
        .en(en),
        .osc_out(ro_bus[i])
      );
    end
  endgenerate

  
  (* KEEP="true", DONT_TOUCH="true" *)
  assign farm_out = ro_bus[0];


endmodule
