module internal_clock(
    output clk_internal
);
    
    wire reset;
    wire clk_100; 
    assign clk_internal = clk_100;
    design_3 design_3
             (.pl_clk0(clk_100),
             .reset(reset)
    ); 
             
endmodule
