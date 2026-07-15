
//`timescale <time_units> / <precision>

module top( 
	input        clk,
	output       andall,
	output [5:0] led,
	output       SEG_DSP_IO1,
	output       SEG_DSP_IO2,
	input        DIP1,
	input        SWITCH1
	);


(* syn_preserve = 1, syn_noprune = 1, syn_keep = 1 *)
wire sys_clk;

(* syn_preserve = 1, syn_noprune = 1, syn_keep = 1 *)
wire locked;
reg [127:0] store;

wire en;

(* syn_preserve = 1 *)
PLLsmrt PLL_inst (
    .clk(clk),
    .powerdown_n(1'b1),
    .sys_clk(sys_clk),
    .locked(locked)
);


//<statements>
(* syn_preserve = 1 *)
MSKregclrBT CMR (
    .clk(sys_clk),
    .in(128'hffffffffffffffffffffffffffffffff),
    .rnd(128'h0),
    .en(en),
    .clear((~locked) | (~SWITCH1)),
    .out(store)
);

assign andall = ~(&store);

assign en = DIP1;
//assign en = (~count[3]) & count[2];
// will hold en high to ensure CMR initialisation for cycles 4-7 after PLL locks
//always @(posedge clk) begin
//    if ((count < 15) && (locked))
//        count <= count + 1;
//end

assign led[0] = locked;
assign led[1] = en;
assign led[2] = 1'b0;
assign led[3] = 1'b0;
assign led[4] = 1'b0;
assign led[5] = 1'b0;

assign SEG_DSP_IO1 = clk;
assign SEG_DSP_IO2 = sys_clk;


endmodule
