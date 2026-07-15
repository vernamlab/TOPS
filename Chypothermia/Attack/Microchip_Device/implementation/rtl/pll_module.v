
module pll_module(
    input clk_in,
    input clk_en,
    output locked,
    output [15:0] clocks_counter,
    output clk_out_pll
    );

    wire clk; 
    wire clk_out; 
    wire temp; 
    assign clk = clk_in & clk_en;
    assign locked = temp;
    
    
    assign clk_out_pll = clk_out;
    
    ccc_module ccc_module(
        // Inputs
        .ref_clk(clk),
        // Outputs
        .out_clk(clk_out),
        .pll_lock(temp)
    );
    
    reg [27:0] cnt1;
    reg [27:0] cnt_main;
    always @(posedge clk_out) cnt1 <= cnt1 + 1;
    always @(posedge clk_in) cnt_main <= cnt_main + 1;
    assign clocks_counter = {cnt1[27:20],cnt_main[27:20]};

endmodule