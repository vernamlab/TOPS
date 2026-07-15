
module pll_module(
    input  clk_in,
    input  clk_en,
    output locked,
    output [15:0] clocks_counter,
    output clk_out_main
);

    wire clk;  
    assign clk = clk_in & clk_en;
    wire temp; 
    assign locked = temp;
    
    wire clk_out;
    assign clk_out_main = clk_out;
    clk_wiz_1 pll_ip
    (
        .clk_out1(clk_out),     
        .locked  (temp),       
        .clk_in1 (clk)     
    );
    
    //Clock Counters 
    reg [27:0] cnt1;
    reg [27:0] cnt_main;
    always @(posedge clk_out) cnt1 <= cnt1 + 1;
    always @(posedge clk_in) cnt_main <= cnt_main + 1;
    assign clocks_counter = {cnt1[27:20],cnt_main[27:20]};       
endmodule