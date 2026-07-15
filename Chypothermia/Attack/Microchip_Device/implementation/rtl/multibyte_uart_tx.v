module multibyte_uart_tx 
#(
//    parameter SYSTEMCLOCK               = 12_500_000, 
    parameter SYSTEMCLOCK               = 12_500_000, 

    parameter BAUDRATE                  = 115_200, 
    parameter ELEMENT_WIDTH             = 8, 
    parameter NUMBER_OF_ELEMENTS        = 256, 
    parameter DELAY_WIDTH               = 32, 
    parameter TRANSFER_COUNTER_WIDTH   = 8
)(
    input  wire                                                clk,
    input  wire                                                rst,
    input  wire                                                tx_en,
    input  wire [NUMBER_OF_ELEMENTS-1:0][ELEMENT_WIDTH-1:0]    tx_data,
    input  wire [TRANSFER_COUNTER_WIDTH:0]                     tx_data_length,
    input  wire [DELAY_WIDTH-1:0]                              delay_between_tx,
    output wire                                                tx_line,
    output reg                                                 tx_ready
);
    
    reg  [ELEMENT_WIDTH-1:0]   uart_tx_data;
    reg                        uart_tx_en;
    wire                       uart_tx_ready;
    uart_tx sender(
        .clk        (clk),
        .rst        (rst),
        .tx_en      (uart_tx_en),
        .tx_data    (uart_tx_data),
        .tx_line    (tx_line),
        .tx_ready   (uart_tx_ready)
    );
    
    defparam sender.BAUDRATE        = BAUDRATE;
    defparam sender.SYSTEMCLOCK     = SYSTEMCLOCK;
    defparam sender.ELEMENT_WIDTH   = ELEMENT_WIDTH;
    
    localparam STATE_IDLE            = 2'd0;
    localparam STATE_TRANSFER        = 2'd1;
    localparam STATE_WAIT_BEWTEEN_TX = 2'd2;

    reg [1:0] current_state;

    //typedef enum {
        //STATE_IDLE, 
        //STATE_TRANSFER, 
        //STATE_WAIT_BEWTEEN_TX
    //} state_t;
    //state_t                                             current_state;
    //state_t                                             state_after_wait;
    reg  [DELAY_WIDTH-1:0]                             delay_counter;
    reg  [TRANSFER_COUNTER_WIDTH-1:0]                  transfer_counter;
    
//    integer i;
    always @(posedge clk) begin
        
        if (rst) begin

            current_state            <= STATE_IDLE;
            uart_tx_en               <= 'b0;
            uart_tx_data             <= 'd0;
            tx_ready                 <= 'b0;
            delay_counter            <= 'd0;
            transfer_counter         <= 'd0;
        
        end else begin
            
            current_state            <= current_state;
            uart_tx_en               <= 'b0;
            uart_tx_data             <= uart_tx_data;
            tx_ready                 <= tx_ready;
            delay_counter            <= delay_counter;
            transfer_counter         <= transfer_counter;
            
            case (current_state)
                
                STATE_IDLE: begin
                    if (tx_en && (tx_data_length > 0)) begin
                        current_state            <= STATE_TRANSFER;
                        transfer_counter         <= 'd0; 
                        tx_ready                 <= 'b0; 
                    end else begin
                        tx_ready <= 'b1;
                    end
                end
                
                STATE_TRANSFER: begin
                    if (uart_tx_ready) begin 
                        uart_tx_data            <= tx_data[transfer_counter];
                        uart_tx_en              <= 'b1;
                        current_state           <= STATE_WAIT_BEWTEEN_TX;
                        delay_counter           <= 'd0;
                        transfer_counter        <= transfer_counter + 1;
                    end
                end
                
                STATE_WAIT_BEWTEEN_TX: begin
                    if (uart_tx_ready) begin
                        delay_counter <= delay_counter + 1;
                        if (delay_counter >= delay_between_tx) begin
                            if (transfer_counter >= tx_data_length) begin
                                current_state <= STATE_IDLE;
                            end else begin
                                current_state <= STATE_TRANSFER;
                            end
                        end
                    end
                end
            endcase
        end
    end
endmodule