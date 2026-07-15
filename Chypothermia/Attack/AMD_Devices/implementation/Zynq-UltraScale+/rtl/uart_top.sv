module uart_top(
    input   logic clk,
    input   logic rst,
    input   logic uart_rx_line,
 
    output  logic uart_tx_line,
    output logic clk_out, 
    output ro_out
    
);  

    localparam SYSTEMCLOCK                      = 12_500_000;
    localparam UART_BAUDRATE                    = 115_200;
    localparam UART_ELEMENT_WIDTH               = 8;
    localparam MULTIBYTE_RX_NUMBER_OF_ELEMENTS  = 256;
    localparam MULTIBYTE_RX_COUNTER_WIDTH       = $clog2(MULTIBYTE_RX_NUMBER_OF_ELEMENTS);

    logic                                                               uart_rx_empty_buffer;
    logic [MULTIBYTE_RX_NUMBER_OF_ELEMENTS-1:0][UART_ELEMENT_WIDTH-1:0] uart_rx_data;
    logic [MULTIBYTE_RX_COUNTER_WIDTH:0]                                uart_rx_data_length;
    logic                                                               uart_rx_updated_buffer;
    logic                                                               uart_rx_overflow;
    multibyte_uart_rx multibyte_uart_rxer (
        .clk                    (clk),
        .rst                    (rst),
        .rx_line                (uart_rx_line),
        .rx_empty_buffer        (uart_rx_empty_buffer),
        .rx_data                (uart_rx_data),
        .rx_data_length         (uart_rx_data_length),
        .rx_updated_buffer      (uart_rx_updated_buffer),
        .rx_overflow            (uart_rx_overflow)
    );
    defparam multibyte_uart_rxer.SYSTEMCLOCK        = SYSTEMCLOCK;
    defparam multibyte_uart_rxer.BAUDRATE           = UART_BAUDRATE;
    defparam multibyte_uart_rxer.ELEMENT_WIDTH      = UART_ELEMENT_WIDTH;
    defparam multibyte_uart_rxer.NUMBER_OF_ELEMENTS = MULTIBYTE_RX_NUMBER_OF_ELEMENTS;

    localparam MULTIBYTE_TX_NUMBER_OF_ELEMENTS        = 256;
    localparam DELAY_COUNTER_WIDTH                    = 32;
    localparam MULTIBYTE_TX_COUNTER_WIDTH             = $clog2(MULTIBYTE_TX_NUMBER_OF_ELEMENTS);

    logic                                                               uart_tx_en;
    logic [MULTIBYTE_TX_NUMBER_OF_ELEMENTS-1:0][UART_ELEMENT_WIDTH-1:0] uart_tx_data;
    logic [MULTIBYTE_TX_COUNTER_WIDTH:0]                                uart_tx_data_length;
    logic [DELAY_COUNTER_WIDTH-1:0]                                     delay_between_tx;
    logic                                                               uart_tx_ready;

    multibyte_uart_tx multibyte_uart_txer (
        .clk                        (clk),
        .rst                        (rst),
        .tx_en                      (uart_tx_en),
        .tx_data                    (uart_tx_data),
        .tx_data_length             (uart_tx_data_length),
        .delay_between_tx           (delay_between_tx),
        .tx_line                    (uart_tx_line),
        .tx_ready                   (uart_tx_ready)
    );
    defparam multibyte_uart_txer.SYSTEMCLOCK               = SYSTEMCLOCK;
    defparam multibyte_uart_txer.BAUDRATE                  = UART_BAUDRATE;
    defparam multibyte_uart_txer.ELEMENT_WIDTH             = UART_ELEMENT_WIDTH;
    defparam multibyte_uart_txer.NUMBER_OF_ELEMENTS        = MULTIBYTE_TX_NUMBER_OF_ELEMENTS;
    defparam multibyte_uart_txer.DELAY_WIDTH               = DELAY_COUNTER_WIDTH;

   
   //internal clock: PS -> PL   , 33.333 MHz
    wire clk_internal;
    internal_clock internal_clock(
        .clk_internal (clk_internal)
    );
    //PLL Implementation
    logic [7:0]      clk_en_reg;
    wire             locked_val;
    reg   [15:0]     clocks_counter;
       
    pll_module pll_module(
        .clk_in         (clk_internal),
        .clk_en         (clk_en_reg[0]),
        .locked         (locked_val),
        .clocks_counter (clocks_counter),
        .clk_out_main        (clk_out)
    );
   
   
   
    //RO implementation
    wire           ro_out_temp;
    wire           en_temp;
    logic [7:0]    ro_en;

    assign ro_out = ro_out_temp;    
    assign en_temp = ro_en[0]; 
    (* DONT_TOUCH = "true" *)
    ro_module ro_module
    (
        .en (en_temp),             
        .ro_out(ro_out_temp)          
    );

    //RO counter
    reg [31:0] ro_counter; 
    reg [7:0] ro_counter_en; 
    ro_counter ro_counter_u(
        .clk     (clk),               
        .en      (ro_counter_en[0]),                
        .ro_out  (ro_out_temp),            
        .counter (ro_counter)   
    );
    
    //SYSMON
    wire [15:0] vccint_code;
    wire [15:0] temp_out_temp;
    wire [15:0] vccaux_code;

    sys_mon sysmon_u(
        .clk (clk_internal), 
        .rst (rst),
        .vccint (vccint_code),
        .temperature (temp_out_temp),
        .vccaux (vccaux_code)
    ); 


    typedef enum {
            STATE_INPUT,

            STATE_SET_CLK_EN, 
            STATE_GET_CLK_EN, 
            STATE_GET_LOCKED,             
            STATE_GET_CLKS_COUNTER,

            STATE_TRANSITION_INPUT,
            
            STATE_GET_TEMP_REG,
            STATE_GET_VINT_REG,
            STATE_GET_VAUX_REG,
            
            STATE_SET_RO_EN, 
            STATE_GET_RO_EN, 
            STATE_SET_RO_COUNT_EN, 
            STATE_GET_RO_COUNT_EN, 
            STATE_GET_RO_COUNTER
    

    } state_t;
    state_t current_state;

    typedef enum logic[7:0] {

        CMD_SET_CLK_EN              = 17,  
        CMD_GET_CLK_EN              = 18,
        CMD_GET_LOCKED              = 21, 
        CMD_GET_CLKS_COUNTER        = 24,
        
        CMD_GET_TEMP_REG            = 34,          
        CMD_GET_VINT_REG            = 35,
        CMD_GET_VAUX_REG            = 36,
        
        CMD_SET_RO_EN             = 40,
        CMD_GET_RO_EN             = 41, 
        CMD_SET_RO_COUNT_EN       = 42, 
        CMD_GET_RO_COUNT_EN       = 43, 
        CMD_GET_RO_COUNTER        = 44

    } command_t;

    localparam DELAY_BETWEEN_TX_DEFAULT   = 'h00000010;
 
    always_ff @(posedge clk) begin

        if (rst) begin
            current_state               <= STATE_INPUT;
            uart_rx_empty_buffer        <= 'b0;
            delay_between_tx            <= DELAY_BETWEEN_TX_DEFAULT;
            uart_tx_en                  <= 'b0;
            for (int i = 0; i < MULTIBYTE_TX_NUMBER_OF_ELEMENTS; i++) begin
                uart_tx_data[i]         <= 'h00;
            end
            uart_tx_data_length         <= 'd0;

        end else begin
            current_state               <= current_state;
            uart_rx_empty_buffer        <= 'b0;
            delay_between_tx            <= delay_between_tx;
            uart_tx_en                  <= 'b0;
            for (int i = 0; i < MULTIBYTE_TX_NUMBER_OF_ELEMENTS; i++) begin
                uart_tx_data[i]         <= uart_tx_data[i];
            end
            uart_tx_data_length         <= uart_tx_data_length;


            case (current_state)
                STATE_INPUT: begin
                    if (uart_rx_updated_buffer) begin
                        case (uart_rx_data[uart_rx_data_length-1])

                            CMD_SET_CLK_EN: begin
                                current_state           <= STATE_SET_CLK_EN;
                                uart_rx_empty_buffer    <= 'b1;
                            end 
                            CMD_GET_CLK_EN: begin
                                current_state           <= STATE_GET_CLK_EN;
                            end 
                            
                            CMD_GET_LOCKED: begin
                                current_state           <= STATE_GET_LOCKED;
                            end 
                            
                            CMD_GET_CLKS_COUNTER: begin
                                current_state           <= STATE_GET_CLKS_COUNTER;
                            end 
                            
                            
                            CMD_GET_TEMP_REG: begin
                                current_state           <= STATE_GET_TEMP_REG;
                            end

                            CMD_GET_VINT_REG: begin
                                current_state           <= STATE_GET_VINT_REG;
                            end
                            
                            CMD_GET_VAUX_REG: begin
                                current_state           <= STATE_GET_VAUX_REG;
                            end

                            
                            CMD_SET_RO_EN: begin
                                current_state           <= STATE_SET_RO_EN;
                                uart_rx_empty_buffer    <= 'b1;
                            end 
                            
                            CMD_GET_RO_EN: begin
                                current_state           <= STATE_GET_RO_EN;
                            end
                            
                            CMD_SET_RO_COUNT_EN: begin
                                current_state           <= STATE_SET_RO_COUNT_EN;
                                uart_rx_empty_buffer    <= 'b1;
                            end 
                            
                            CMD_GET_RO_COUNT_EN: begin
                                current_state           <= STATE_GET_RO_COUNT_EN;
                            end
                            CMD_GET_RO_COUNTER: begin
                                current_state           <= STATE_GET_RO_COUNTER;
                            end
                                     
                            default: begin
                                current_state           <= STATE_TRANSITION_INPUT;
                                
                            end
                            
                        endcase
                    end
                end

               STATE_SET_CLK_EN: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd1) begin
                               clk_en_reg <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end


               STATE_GET_CLK_EN: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0] <= clk_en_reg;
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
                
                STATE_SET_RO_EN: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd1) begin
                               ro_en <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end


               STATE_GET_RO_EN: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0] <= ro_en;
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
                STATE_SET_RO_COUNT_EN: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd1) begin
                               ro_counter_en <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end


               STATE_GET_RO_COUNT_EN: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0] <= ro_counter_en;
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
               
                
                STATE_GET_RO_COUNTER: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[3] <= ro_counter[7:0];
                        uart_tx_data[2] <= ro_counter[15:8];
                        uart_tx_data[1] <= ro_counter[23:16];
                        uart_tx_data[0] <= ro_counter[31:24];
                        uart_tx_data_length <= 'd4;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                


               STATE_GET_LOCKED: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0] <= {8{locked_val}}; 
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 


                
                STATE_GET_CLKS_COUNTER: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1] <= clocks_counter[7:0] ;
                        uart_tx_data[0] <= clocks_counter[15:8] ;
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
                
                STATE_GET_TEMP_REG: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1] <= temp_out_temp[7:0] ;
                        uart_tx_data[0] <= temp_out_temp[15:8] ;
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                

                
             
                STATE_GET_VINT_REG: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1] <= vccint_code[7:0] ;
                        uart_tx_data[0] <= vccint_code[15:8] ;
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
                STATE_GET_VAUX_REG: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1] <= vccaux_code[7:0] ; 
                        uart_tx_data[0] <= vccaux_code[15:8] ;
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
     

                STATE_TRANSITION_INPUT: begin
                    uart_rx_empty_buffer    <= 'b1;
                    current_state           <= STATE_INPUT;
                end
            endcase
        end
    end
endmodule