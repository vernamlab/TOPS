module top_main_module
(
    input   wire clk, //12.5MHz-external clk
    input   wire rst, 
    input   wire uart_rx_line, 
    output  wire uart_tx_line,
    output wire clk_out,   // PLL clock output
    output ro_out,         // RO output
    
    output wire temp_low,
    output wire temp_high  
); 
    //UART setting
    localparam SYSTEMCLOCK                      = 12_500_000;
    localparam UART_BAUDRATE                    = 115_200;
    localparam UART_ELEMENT_WIDTH               = 8;
    localparam MULTIBYTE_RX_NUMBER_OF_ELEMENTS  = 256;
    localparam MULTIBYTE_RX_COUNTER_WIDTH       = 8;

    reg                                                                uart_rx_empty_buffer;
    wire [MULTIBYTE_RX_NUMBER_OF_ELEMENTS-1:0][UART_ELEMENT_WIDTH-1:0] uart_rx_data;
    wire [MULTIBYTE_RX_COUNTER_WIDTH:0]                                uart_rx_data_length;
    wire                                                               uart_rx_updated_buffer;
    wire                                                               uart_rx_overflow;
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
    localparam MULTIBYTE_TX_COUNTER_WIDTH             = $clog2(         MULTIBYTE_TX_NUMBER_OF_ELEMENTS);

    reg                                                                uart_tx_en;
    reg  [MULTIBYTE_TX_NUMBER_OF_ELEMENTS-1:0][UART_ELEMENT_WIDTH-1:0] uart_tx_data;
    reg  [MULTIBYTE_TX_COUNTER_WIDTH:0]                                uart_tx_data_length;
    reg  [DELAY_COUNTER_WIDTH-1:0]                                     delay_between_tx;
    wire                                                               uart_tx_ready;

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



    //Internal clock - 2MHz - OSC IP
    wire clk_sys;
    wire clk_internal;
    sys_clk_orig sys_clk_orig(
        .CLK_SYS(clk_sys)
    );
    assign clk_internal = clk_sys;

    reg [15:0] clocks_counter;
    reg[7:0]     clk_en_reg;
    wire         locked_reg;
    //PLL module
    pll_module pll_module(
        .clk_in (clk_internal),
        .clk_en (clk_en_reg[0]),
        .locked (locked_reg),
        .clocks_counter (clocks_counter),
        .clk_out_pll (clk_out)
    );

    //RO and its counter
    (* syn_keep = 1, syn_preserve = 1, syn_noprune = 1 *)
    reg [7:0]    ro_en;
    wire en_temp; 
    wire ro_out_temp; 
    assign en_temp = ro_en[0];
    assign ro_out = ro_out_temp;
    (* S = "true" *)
    (* syn_preserve = 1, syn_keep = 1, DONT_TOUCH = "true" *)
    ro_module ro_module
    (
        .en (en_temp),                 
        .ro_out(ro_out_temp)
    );

    reg [31:0] ro_counterr; 
    reg [7:0] re_counter_en; 
    ro_counter ro_counter_u(
        .clk (clk),               
        .ro_count_en (re_counter_en[0]),              
        .ro_out (ro_out_temp),          
        .counter (ro_counterr)  
    );
    
    
    //TVS
    wire [15:0] temp_out_temp;
    wire [15:0] vdd1_0p_code;
    wire [15:0] vdd1_8p_code;
    wire [15:0] vdd2_5p_code;

    tvs_design tvs_design(
        .clk (clk_internal),
        .rst(rst),
        .temp_low(temp_low),
        .temp_high (temp_high),
        .temp(temp_out_temp),
        .vcc1_0p(vdd1_0p_code),
        .vcc1_8P(vdd1_8p_code),
        .vcc2_5P(vdd2_5p_code)
    );
    
    
    



    localparam STATE_INPUT               = 5'd0;
    localparam STATE_SET_CLK_EN          = 5'd1;
    localparam STATE_GET_CLK_EN          = 5'd2;
    localparam STATE_GET_LOCKED          = 5'd5;
    localparam STATE_GET_CLKS_COUNTER    = 5'd8;
    localparam STATE_TRANSITION_INPUT    = 5'd9;

    localparam STATE_GET_TEMP_REG        = 5'd10;
    localparam STATE_GET_VINT_REG        = 5'd13;
    localparam STATE_GET_V1P8_REG        = 5'd14;
    localparam STATE_GET_V2P5_REG        = 5'd15;


    localparam STATE_SET_RO_EN           = 5'd17;
    localparam STATE_GET_RO_EN           = 5'd18;
    localparam STATE_SET_RO_COUNT_EN     = 5'd19;
    localparam STATE_GET_RO_COUNT_EN     = 5'd20;
    localparam STATE_GET_RO_COUNTER      = 5'd21;


    reg [4:0] current_state;

    localparam [7:0] CMD_SET_CLK_EN            = 8'd17;
    localparam [7:0] CMD_GET_CLK_EN            = 8'd18;
    localparam [7:0] CMD_GET_LOCKED            = 8'd21;
    localparam [7:0] CMD_GET_CLKS_COUNTER      = 8'd24;

    localparam [7:0] CMD_GET_TEMP_REG          = 8'd34;
    localparam [7:0] CMD_GET_VINT_REG          = 8'd35;
    localparam [7:0] CMD_GET_V1P8_REG          = 8'd37;
    localparam [7:0] CMD_GET_V2P5_REG          = 8'd38;


    localparam [7:0] CMD_SET_RO_EN             = 8'd40;
    localparam [7:0] CMD_GET_RO_EN             = 8'd41;
    localparam [7:0] CMD_SET_RO_COUNT_EN       = 8'd42;
    localparam [7:0] CMD_GET_RO_COUNT_EN       = 8'd43;
    localparam [7:0] CMD_GET_RO_COUNTER        = 8'd44;



    localparam DELAY_BETWEEN_TX_DEFAULT   = 'h00000010;




    integer i_1;
    integer i_2;
    always @(posedge clk) begin
        
        if (rst) begin
            current_state               <= STATE_INPUT;
            uart_rx_empty_buffer        <= 'b0;
            delay_between_tx            <= DELAY_BETWEEN_TX_DEFAULT;
            uart_tx_en                  <= 'b0;
            
            for (i_1 = 0; i_1 < MULTIBYTE_TX_NUMBER_OF_ELEMENTS; i_1=i_1+1) begin
                uart_tx_data[i_1]         <= 'h00;
            end
            uart_tx_data_length         <= 'd0;
            
            clk_en_reg           <= 8'd0;
            ro_en                <= 8'd0;
            re_counter_en        <= 8'd0;
            
        end else begin
            current_state               <= current_state;
            uart_rx_empty_buffer        <= 'b0;
            delay_between_tx            <= delay_between_tx;
            uart_tx_en                  <= 'b0;
            for (i_2 = 0; i_2 < MULTIBYTE_TX_NUMBER_OF_ELEMENTS; i_2=i_2+1) begin
                uart_tx_data[i_2]         <= uart_tx_data[i_2];
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
                            
                            CMD_GET_V1P8_REG: begin
                                current_state           <= STATE_GET_V1P8_REG;
                            end
                            
                            CMD_GET_V2P5_REG: begin
                                current_state           <= STATE_GET_V2P5_REG;
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
                               re_counter_en <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end
                
               STATE_GET_RO_COUNT_EN: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0] <= re_counter_en;
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
               
                STATE_GET_RO_COUNTER: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[3] <= ro_counterr[7:0];
                        uart_tx_data[2] <= ro_counterr[15:8];
                        uart_tx_data[1] <= ro_counterr[23:16];
                        uart_tx_data[0] <= ro_counterr[31:24];
                        uart_tx_data_length <= 'd4;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
               STATE_GET_LOCKED: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0] <= {8{locked_reg}}; 
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
                        uart_tx_data[1] <= vdd1_0p_code[7:0] ;
                        uart_tx_data[0] <= vdd1_0p_code[15:8] ;
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
                
                STATE_GET_V1P8_REG: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1] <= vdd1_8p_code[7:0] ; 
                        uart_tx_data[0] <= vdd1_8p_code[15:8] ;
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end 
                
                STATE_GET_V2P5_REG: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1] <= vdd2_5p_code[7:0] ; 
                        uart_tx_data[0] <= vdd2_5p_code[15:8] ;
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

