module top_main_module(
      output wire                         clk_output,   
      output wire                         ro_output,
      input  wire                         clk_in,      
      input  wire                         rst,
      input  wire                         uart_rx_line,
      output wire                         uart_tx_line
);

    wire clk_temp ;
    wire ro_out_temp; 
    
    uart_top uart_top
    (
        .clk(clk_in), 
        .rst(rst),
        .uart_rx_line(uart_rx_line),
        .uart_tx_line(uart_tx_line),
        .clk_out(clk_temp),
        .ro_out(ro_out_temp)
    );
     
    
    assign  clk_output = clk_temp ; 
    assign ro_output = ro_out_temp;
    

endmodule



