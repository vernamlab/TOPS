
(* syn_hier = "hard" *)
module MSKregclrBT #( parameter WIDTH = 128 )(
    input  wire                   clk,
    input  wire [WIDTH-1:0]       in,
    input  wire [WIDTH-1:0]       rnd,
    input  wire                   en,
    input  wire                   clear,
    output wire [WIDTH-1:0]       out
);

(* syn_preserve = 1, syn_noprune = 1, syn_keep = 1 *) wire [WIDTH-1:0] Q_C;

(* syn_preserve = 1, syn_noprune = 1, syn_keep = 1 *) wire [WIDTH-1:0] Q_P;

genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : complementary_masked_clr_reg_gen
            
            (* syn_preserve = 1, syn_noprune = 1, syn_keep = 1 *)
            DFN1E1C0 Clear_reg(
                .E(en),
                .D(rnd[i]^in[i]),
                .CLR(~clear),       // active low clear
                .CLK(clk),
                .Q(Q_C[i])
            );

            (* syn_preserve = 1, syn_noprune = 1, syn_keep = 1 *)        
            DFN1E1P0 Preset_reg(
                .E(en),
                .D(~rnd[i]^in[i]),
                .PRE(~clear),       // active low preset
                .CLK(clk),
                .Q(Q_P[i])
            );

            assign out[i] = rnd[i] ^ (Q_C[i] & (~Q_P[i]));
        end
    endgenerate
//<statements>

endmodule

