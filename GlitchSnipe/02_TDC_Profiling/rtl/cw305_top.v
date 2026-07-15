

module cw305_top (
    output wire                         led1,           // red LED
    output wire                         led2,           // green LED
    output wire                         led3,           // blue LED

    input wire                          pll_clk1_org,       //PLL Clock Channel #1

    input  wire                         rst,
    input  wire                         uart_rx_line,
    output wire                         uart_tx_line
);

    wire clk;
    wire internal_tdc_clk;
    wire led_temp ;
       
    
    clk_wiz_0  clk_wiz_0
    (
        // Clock out ports
        .clk_100(clk),              // output clk_sys  = 100
        .clk_250(internal_tdc_clk),     // output clk_tdc  = 250
        .clk_in1(pll_clk1_org)       // input clk_in1
    );

    TDC_UART_module  TDC_UART_module
    (
            .clk(clk), 
            .rst(rst),
            .uart_rx_line(uart_rx_line),
            .internal_tdc_clk(internal_tdc_clk),   //internal clock 
            .uart_tx_line(uart_tx_line),
            .led_temp(led_temp)
    );

    reg [26:0] counter;
    reg led3_temp = 0;
    localparam DIVISOR = 100_000_000; 
    
    always @(posedge clk) begin
        if (counter == DIVISOR - 1) begin
            counter <= 0;        
            led3_temp <= ~led3_temp;         
        end else begin
            counter <= counter + 1;
        end
    end
      
    assign  led1 = led_temp ; 
    assign  led2 =  1'b1;
    assign  led3 = led3_temp ;
         
endmodule
