module uart_tx 
#(
//    parameter SYSTEMCLOCK                = 12_500_000, 
    parameter SYSTEMCLOCK               = 12_500_000, 

    parameter BAUDRATE                   = 115_200,
    parameter ELEMENT_WIDTH              = 8,
    parameter ELEMENT_BIT_COUNTER_WIDTH = 3,
    parameter CLOCK_COUNTER_WIDTH       = 32,
    parameter CLOCKS_PER_BAUD           = SYSTEMCLOCK / BAUDRATE
)(
    input  wire                     clk,
    input  wire                     rst,
    input  wire                     tx_en,
    input  wire [ELEMENT_WIDTH-1:0] tx_data,
    output reg                     tx_line,
    output reg                     tx_ready
);

    //typedef enum {
        //STATE_IDLE, 
        //STATE_START_BIT, 
        //STATE_TRANSFER_ELEMENT, 
        //STATE_CHECK_ELEMENT_TRANSFERRED,
        //STATE_STOP_BIT, 
        //STATE_DONE
    //} state_t;
    //state_t current_state;
    
    localparam STATE_IDLE                      = 3'd0;
    localparam STATE_START_BIT                 = 3'd1;
    localparam STATE_TRANSFER_ELEMENT          = 3'd2;
    localparam STATE_CHECK_ELEMENT_TRANSFERRED = 3'd3;
    localparam STATE_STOP_BIT                  = 3'd4;
    localparam STATE_DONE                      = 3'd5;

    reg [2:0] current_state;

    reg [ELEMENT_BIT_COUNTER_WIDTH:0]     bit_counter    = 'b0;
    reg [CLOCK_COUNTER_WIDTH:0]           clock_counter  = 'b0;
    
    wire clocks_per_baud_reached;
    assign clocks_per_baud_reached = (clock_counter >= CLOCKS_PER_BAUD);

    always @(posedge clk) begin
    
        if (rst) begin
            current_state     <= STATE_IDLE;
            bit_counter       <= 'd0;
            clock_counter     <= 'd0;
            tx_line           <= 'b1;
            tx_ready          <= 'b0;
            
        end else begin
            
            clock_counter <= clock_counter + 1;
            current_state <= current_state;
            bit_counter   <= bit_counter;
            tx_line       <= tx_line;
            tx_ready      <= tx_ready;
            
            case (current_state)
            
                STATE_IDLE: begin
                    if (tx_en) begin
                        current_state <= STATE_START_BIT;
                        tx_line    <= 'b0;
                        tx_ready   <= 'b0;
                    end else begin
                        tx_line    <= 'b1;
                        tx_ready   <= 'b1;
                    end
                end
                
                STATE_START_BIT: begin
                        current_state <= STATE_TRANSFER_ELEMENT;
                        bit_counter   <= 'd0;
                        clock_counter <= 'd0;
                end
                
                STATE_TRANSFER_ELEMENT: begin
                    if(clocks_per_baud_reached) begin
                        clock_counter     <= 'b0;
                        tx_line           <= tx_data[bit_counter];
                        bit_counter       <= bit_counter + 1;
                        current_state     <= STATE_CHECK_ELEMENT_TRANSFERRED;
                    end
                end
                
                STATE_CHECK_ELEMENT_TRANSFERRED: begin
                    if (bit_counter >= ELEMENT_WIDTH) begin
                        current_state <= STATE_STOP_BIT;
                    end else begin
                        current_state <= STATE_TRANSFER_ELEMENT;
                    end
                end
                
                STATE_STOP_BIT: begin
                    if(clocks_per_baud_reached) begin
                        tx_line       <= 'b1;
                        clock_counter <= 'd0;
                        current_state <= STATE_DONE;
                    end
                end
                
                STATE_DONE: begin
                    if (clocks_per_baud_reached) begin
                        tx_ready         <= 'b1;
                        current_state <= STATE_IDLE;
                    end
                end
            endcase
        end
    end
endmodule