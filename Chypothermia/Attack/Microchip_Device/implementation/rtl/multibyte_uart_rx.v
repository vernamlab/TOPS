module multibyte_uart_rx 
#(
//    parameter SYSTEMCLOCK           = 12_500_000, 
    parameter SYSTEMCLOCK           = 12_500_000, 

    parameter BAUDRATE              = 115_200, 
    parameter ELEMENT_WIDTH         = 8, 
    parameter NUMBER_OF_ELEMENTS    = 256, 
    parameter DATA_LENGTH_COUNTER_WIDTH = 8
)(
    input  wire                                             clk,
    input  wire                                             rst,
    input  wire                                             rx_line,
    input  wire                                             rx_empty_buffer,

    output reg [NUMBER_OF_ELEMENTS-1:0][ELEMENT_WIDTH-1:0] rx_data,
    output reg [DATA_LENGTH_COUNTER_WIDTH:0]               rx_data_length,
    output reg                                             rx_updated_buffer,
    output reg                                             rx_overflow
);

    wire [ELEMENT_WIDTH-1:0]   uart_rx_data;
    wire                       uart_rx_data_valid;
    
    uart_rx receiver (
        .clk(clk),
        .rst(rst),
        .rx_line(rx_line),
        .rx_data(uart_rx_data),
        .rx_data_valid(uart_rx_data_valid)
    );
    defparam receiver.BAUDRATE      = BAUDRATE;
    defparam receiver.SYSTEMCLOCK   = SYSTEMCLOCK;
    defparam receiver.ELEMENT_WIDTH = ELEMENT_WIDTH;
    
    always @(posedge clk) begin
    
        if (rst || rx_empty_buffer) begin
            rx_data_length    <= 'd0;
            rx_data           <= 'b0;
            rx_updated_buffer <= 'b0;
            rx_overflow       <= 'b0;
            
        end else begin
            rx_data_length    <= rx_data_length;
            rx_data           <= rx_data;
            rx_updated_buffer <= 'b0;
            rx_overflow       <= rx_overflow;
            
            if (uart_rx_data_valid) begin
                if (rx_data_length < NUMBER_OF_ELEMENTS) begin
                    rx_data[rx_data_length] <= uart_rx_data;
                    rx_data_length          <= rx_data_length + 1;
                    rx_updated_buffer       <= 'b1;
                end else begin
                    rx_overflow             <= 'b1;
                end
            end
    
        end
    end
endmodule