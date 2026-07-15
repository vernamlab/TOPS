`timescale 1ns/1ps

module TDC_UART_module
(
    input   logic clk,
    input   logic rst,
    input   logic uart_rx_line,
    input   logic internal_tdc_clk,
    output  logic uart_tx_line,
    output logic led_temp
);



    localparam SYSTEMCLOCK                      = 100_000_000;
//        localparam SYSTEMCLOCK                      = 10_000_000;

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


    localparam RO_MEAS_BITS     = 64;
    localparam AES_BITS         = 128;

    localparam RO_EMAS_BYTE             = $clog2(RO_MEAS_BITS);
    localparam CLK_INT_DIV_BITS     = 32;
    localparam CLK_FRC_DIV_BITS     = 32;


    localparam RO_INST                   = 4;
    logic [RO_INST-1:0]                 ro_en;
    logic [RO_INST-1:0]                 ro_out;

    logic  [RO_MEAS_BITS-1:0] ro_meas_time;


    logic  [RO_INST-1:0][RO_MEAS_BITS-1:0] ro_meas_count;
//    logic  [RO_MEAS_BITS-1:0] ro_meas_count;

    logic     ro_counter_en;
    logic[7:0]     ro_id_reg;





//     (* S = "TRUE" *) (* KEEP = "TRUE" *)    ro_core RO[RO_INST-1:0](

//       .in_d           (ro_en),
//       .wire_inj          (ro_out)

//   );




    localparam TDC_MAX_SMPL_RATE          = 8;
    localparam TDC_MAX_SMPL_CYCLE         = 1024;
    localparam TDC_MAX_MEAS_TIME          = TDC_MAX_SMPL_RATE*TDC_MAX_SMPL_CYCLE;
    localparam TDC_MAX_MEAS_TIME_BITS     = 16;
    localparam TDC_INST                   = 79;  ////////////////////////////////
    localparam TDC_INST_WIDTH             = 79; ////////////////
    localparam SENSOR_WIDTH               = 64;   ////////////////
    localparam COARSE_WIDTH               = 32;  
    localparam FINE_WIDTH                 = 24;
    logic  [TDC_INST-1:0] it                       = 0;    ///////////////////////////////////////////////
//    localparam URAM_ADDRESS_WIDTH         = $clog2(TDC_MAX_MEAS_TIME*SENSOR_WIDTH);
    localparam URAM_ADDRESS_WIDTH         = $clog2(TDC_MAX_MEAS_TIME);
    localparam URAM_ADDRESS_MAX_WIDTH     = 16;

    logic [COARSE_WIDTH-1:0]            tdc_coarse_delay_id;
    logic [4*FINE_WIDTH-1:0]            tdc_fine_delay_id;
//    logic                               tdc_clk;
    logic  [TDC_INST_WIDTH-1:0]          tdc_id_reg;
    logic  [TDC_INST-1:0]                    tdc_en;
    logic  [TDC_MAX_MEAS_TIME_BITS-1:0]     tdc_meas_cycle;
    logic  [TDC_INST-1:0][SENSOR_WIDTH-1:0] tdc_out;
    logic  [TDC_INST-1:0]                   tdc_trigger_en;
    logic  [TDC_INST-1:0][TDC_INST_WIDTH-1:0]  tdc_s_id;

    initial begin
    for (int i = 0; i < TDC_INST; i++) begin
        tdc_s_id[i] = i + 1; 
        end
    end
      logic clk_pll_250mhz;
      assign clk_pll_250mhz = internal_tdc_clk; //250mhz

    
    // Array of parameters for each instance
    localparam int SET_NUMBER [78:0] = '{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,25,26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54,55, 56,57,58,59, 60, 61,62,63,64,65,66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79};

    genvar i;
    generate
        for (i = 0; i < TDC_INST; i = i + 1) begin : TDC_sensor_instances
            TDC_sensor #(
                .COARSE_WIDTH(32),         // Shared generic   
                .FINE_WIDTH(24),           // Shared generic
                .SENSOR_WIDTH(64),        // Shared generic    ///////////128
                .SET_NUMBER(SET_NUMBER[i])// Unique parameter for each instance
            ) TDC (
                .clk_i(clk_pll_250mhz),               // Shared clock input
                .sampling_clk_i(clk_pll_250mhz), // Shared sampling clock input
                .id_coarse_i(tdc_coarse_delay_id), // Unique signal for id_coarse
                .enable_i(tdc_en[i]),       // Unique signal for enable
                .id_fine_i(tdc_fine_delay_id),     // Unique signal for id_fine
                .sensor_o(tdc_out[i])    // Unique signal for sensor_out
            );
        end
    endgenerate



    logic                  tdc_write_mem;                    // Write Enable
    logic                   [TDC_INST-1:0] tdc_write;
    logic                  [TDC_INST-1:0]  tdc_en_mem;                 // Memory Enable
    logic                  [TDC_INST-1:0]  [SENSOR_WIDTH-1:0] tdc_din;  // Data Input
    logic                   [TDC_INST-1:0] [URAM_ADDRESS_MAX_WIDTH-1:0] tdc_addr_write   ;    // Write Address
    logic                  [TDC_INST-1:0] [URAM_ADDRESS_MAX_WIDTH-1:0] tdc_addr_read;     // Read  Address
    logic                     [TDC_INST-1:0] [SENSOR_WIDTH-1:0] tdc_dout; // Data Output
    assign tdc_en_mem  = {TDC_INST{1'b1}};
   //Ultra RAM instantiation
    bram_module # (
        .AWIDTH(URAM_ADDRESS_MAX_WIDTH),
        .DWIDTH(SENSOR_WIDTH),
        .NBPIPE(3)
    )
    bram_inst[TDC_INST-1:0] (
        .clk(clk_in1),
        .wea(tdc_write),
        .mem_en(tdc_en_mem),
        .dina(tdc_din),
        .addra(tdc_addr_write),
        .addrb(tdc_addr_read),
        .doutb(tdc_dout)
    );
			



   	genvar k;
    generate
        for (k = 0; k < TDC_INST; k = k + 1) begin : TDC_SENS_instance
            TDC_measure_core #(
                 .tdc_meas_size(TDC_MAX_MEAS_TIME_BITS),
                 .tdc_width_size(SENSOR_WIDTH),
                 .tdc_address_width_size(URAM_ADDRESS_MAX_WIDTH)
            ) TDC_CORE (
                   .tdc_meas_time    (tdc_meas_cycle),
                   .tdc_clk             (clk_pll_250mhz),
                   .tdc_out           (tdc_out[k]), // Input: TDC sensor output fed into the core
                   .tdc_trigger_en          (tdc_trigger_en[k]), // Input
                   .ram_write_flag          (tdc_write[k]), //Output
                   .data_to_ram           (tdc_din[k]), // Output
                   .ram_write_address      (tdc_addr_write[k]) //Output
            );
        end
    endgenerate





//URAM for user Porpuses

    localparam  URAM_DATA_WIDTH     = 8;
    localparam  USER_ADDRESS_WIDTH  = 16;
    logic                       uram_write_mem;                    // Write Enable
    logic                       uram_en_mem;                 // Memory Enable
    logic                       [URAM_DATA_WIDTH-1:0] uram_din;      // Data Input
    logic                       [USER_ADDRESS_WIDTH-1:0] uram_addr_write;     // Write Address
    logic                       [USER_ADDRESS_WIDTH-1:0] uram_addr_read;     // Read  Address
    reg                         [URAM_DATA_WIDTH-1:0] uram_dout; // Data Output

   //Ultra RAM instantiation
   bram_module # (
         .AWIDTH(USER_ADDRESS_WIDTH),
         .DWIDTH(URAM_DATA_WIDTH),
         .NBPIPE(3)
    )
    bram_user_inst   (
         .clk(clk),
         .wea(uram_write_mem),
         .mem_en('b1),
         .dina(uram_din),
         .addra(uram_addr_write),
         .addrb(uram_addr_read),
         .doutb(uram_dout)
    );

//        (* S = "TRUE" *) (* KEEP = "TRUE" *)    ro_sensor #(.width_size(RO_MEAS_BITS))  RO_SENS[RO_INST-1:0] (
//       .ro_meas_time    (ro_meas_time),
//       .clk             (clk),
//       .r_out           (ro_out),
//       .ro_counter_en          (ro_counter_en),
//       .ro_meas_count           (ro_meas_count)
//   );




    typedef enum {
            STATE_INPUT,
            STATE_UNHULT_CLK,
            STATE_HULT_CLK,
            STATE_SET_FF_VAL,
            STATE_GET_FF_VAL,
            STATE_LOCK_VAL,
            STATE_SET_FF_ID,
            STATE_GET_FF_ID,
            //RO STATES
            STATE_SET_RO_VAL,
            STATE_GET_RO_VAL,
            STATE_SET_RO_ID,
            STATE_GET_RO_ID,
            STATE_SET_RO_MEAS_TIME,
            STATE_GET_RO_MEAS_TIME,
            STATE_GET_MEAS_RO,
            STATE_EXEC_MEAS_RO,
            STATE_EXEC_MEAS_RO_POST,
            //AES STATES
            STATE_SET_AES_PTX,
            STATE_GET_AES_PTX,
            STATE_SET_AES_KEY,
            STATE_GET_AES_KEY,
            STATE_GET_AES_CTX,
            //CHAIN STATES
            STATE_ACTIVATE_CHAIN,
            STATE_DEACTIVATE_CHAIN,
            STATE_SET_CHAIN_FREQ_INT,
            STATE_GET_CHAIN_FREQ_INT,
            STATE_SET_CHAIN_FREQ_FRAC,
            STATE_GET_CHAIN_FREQ_FRAC,
//          STATE_GET_NUMBER_OF_NCS,
            STATE_SET_GPIO,
            STATE_UNSET_GPIO,
            STATE_TRANSITION_INPUT,

            STATE_GET_TEMP_REG,
            STATE_GET_VINT_REG,
            STATE_GET_VAUX_REG,

            //STATE CHAIN
            STATE_SET_CHAIN_VAL,
            STATE_GET_CHAIN_VAL,
            STATE_SET_CHAIN_ID,
            STATE_GET_CHAIN_ID,

            //STATE TDC
            STATE_GET_TDC_VAL,
            STATE_SET_TDC_VAL,
            STATE_SET_TDC_ID,
            STATE_GET_TDC_ID,
            STATE_SET_TDC_MEAS_CYCLE,
            STATE_GET_TDC_MEAS_CYCLE,
            STATE_GET_MEAS_TDC,
            STATE_TRIG_MEAS_TDC,
            STATE_TRIG_MEAS_TDC_POST,
            STATE_GET_COARSE_TUNE_TDC,
            STATE_SET_COARSE_TUNE_TDC,
            STATE_GET_FINE_TUNE_TDC,
            STATE_SET_FINE_TUNE_TDC,
            STATE_SET_TDC_FREQ_INT,
            STATE_GET_TDC_FREQ_INT,
            STATE_SET_TDC_FREQ_FRAC,
            STATE_GET_TDC_FREQ_FRAC,
            STATE_SET_TDC_READ_ADDR,
            STATE_GET_TDC_READ_ADDR,

            //User Defined URAM STATE
            STATE_SET_URAM_READ_ADDR,
            STATE_GET_URAM_READ_ADDR,
            STATE_SET_URAM_WRITE_ADDR,
            STATE_GET_URAM_WRITE_ADDR,
            STATE_READ_URAM_DATA,
            STATE_WRITE_URAM_DATA,
            STATE_URAM_POST_WRITE,

            //TDC_TEST
            STATE_SET_CAL_TDC_TEST,
            STATE_GET_MEAS_TDC_TEST,

                       //STATE RDS
            STATE_GET_RDS_VAL,
            STATE_SET_RDS_VAL,
            STATE_SET_RDS_ID,
            STATE_GET_RDS_ID,
            STATE_SET_RDS_MEAS_CYCLE,
            STATE_GET_RDS_MEAS_CYCLE,
            STATE_GET_MEAS_RDS,
            STATE_TRIG_MEAS_RDS,
            STATE_TRIG_MEAS_RDS_POST,
            STATE_GET_COARSE_TUNE_RDS,
            STATE_SET_COARSE_TUNE_RDS,
            STATE_GET_FINE_TUNE_RDS,
            STATE_SET_FINE_TUNE_RDS,
            STATE_SET_RDS_FREQ_INT,
            STATE_GET_RDS_FREQ_INT,
            STATE_SET_RDS_FREQ_FRAC,
            STATE_GET_RDS_FREQ_FRAC,
            STATE_SET_RDS_READ_ADDR,
            STATE_GET_RDS_READ_ADDR,
            STATE_READ_TDC_FROM_URAM


    } state_t;
    state_t current_state;

    typedef enum logic[7:0] {
        CMD_UNHULT_CLK              =  7,
        CMD_HULT_CLK                =  8,
        CMD_SET_FF_VAL              =  9,
        CMD_GET_FF_VAL              = 10,
        CMD_SET_FF_ID               = 11,
        CMD_GET_FF_ID               = 12,
//        CMD_GET_NUMBER_OF_NCS       = 11,
        CMD_SET_GPIO                = 13,
        CMD_UNSET_GPIO              = 14,
        CMD_SET_RO_VAL              =  15,
        CMD_GET_RO_VAL              = 16,
        CMD_SET_RO_ID               = 17,
        CMD_GET_RO_ID               = 18,
        CMD_SET_RO_MEAS_TIME        = 19,
        CMD_GET_RO_MEAS_TIME        = 20,
        CMD_GET_MEAS_RO             = 21,
        CMD_EXEC_MEAS_RO            = 22,
        CMD_ACTIVATE_CHAIN          = 23,
        CMD_DEACTIVATE_CHAIN        = 24,
        CMD_SET_CHAIN_FREQ_INT      = 25,
        CMD_GET_CHAIN_FREQ_INT      = 26,
        CMD_SET_CHAIN_FREQ_FRAC     = 27,
        CMD_GET_CHAIN_FREQ_FRAC     = 28,

        CMD_SET_AES_PTX             = 29,
        CMD_GET_AES_PTX             = 30,
        CMD_SET_AES_KEY             = 31,
        CMD_GET_AES_KEY             = 32,
        CMD_GET_AES_CTX             = 33,
//        CMD_AES_EXEC                = 34
        CMD_GET_TEMP_REG            = 34,
        CMD_GET_VINT_REG            = 35,
        CMD_GET_VAUX_REG            = 36,

        CMD_SET_CHAIN_VAL           = 37,
        CMD_GET_CHAIN_VAL           = 38,
        CMD_SET_CHAIN_ID            = 39,
        CMD_GET_CHAIN_ID            = 40,
        // TDC Commands
        CMD_GET_TDC_VAL              = 41,
        CMD_SET_TDC_VAL              = 42,
        CMD_SET_TDC_ID               = 43,
        CMD_GET_TDC_ID               = 44,
        CMD_SET_TDC_MEAS_CYCLE       = 45,
        CMD_GET_TDC_MEAS_CYCLE       = 46,
        CMD_GET_MEAS_TDC             = 47,
        CMD_TRIG_MEAS_TDC            = 48,
        CMD_GET_COARSE_TUNE_TDC      = 49,
        CMD_SET_COARSE_TUNE_TDC      = 50,
        CMD_GET_FINE_TUNE_TDC        = 51,
        CMD_SET_FINE_TUNE_TDC        = 52,
        CMD_SET_TDC_FREQ_INT         = 53,
        CMD_GET_TDC_FREQ_INT         = 54,
        CMD_SET_TDC_FREQ_FRAC        = 55,
        CMD_GET_TDC_FREQ_FRAC        = 56,
        CMD_SET_TDC_READ_ADDR        = 57,
        CMD_GET_TDC_READ_ADDR        = 58,


        //USER URAM COMMANDS
       CMD_SET_URAM_READ_ADDR       = 59,
       CMD_GET_URAM_READ_ADDR       = 60,
       CMD_SET_URAM_WRITE_ADDR      = 61,
       CMD_GET_URAM_WRITE_ADDR      = 62,
       CMD_READ_URAM_DATA           = 63,
       CMD_WRITE_URAM_DATA          = 64,
       //TDC_TEST
       CMD_SET_CAL_TDC_TEST =    65,
       CMD_GET_MEAS_TDC_TEST =   66,

        //RDS COMMANDS
        CMD_GET_RDS_VAL              = 67,
        CMD_SET_RDS_VAL              = 68,
        CMD_SET_RDS_ID               = 69,
        CMD_GET_RDS_ID               = 70,
        CMD_SET_RDS_MEAS_CYCLE       = 71,
        CMD_GET_RDS_MEAS_CYCLE       = 72,
        CMD_GET_MEAS_RDS             = 73,
        CMD_TRIG_MEAS_RDS            = 74,
        CMD_GET_COARSE_TUNE_RDS      = 75,
        CMD_SET_COARSE_TUNE_RDS      = 76,
        CMD_GET_FINE_TUNE_RDS        = 77,
        CMD_SET_FINE_TUNE_RDS        = 78,
        CMD_SET_RDS_FREQ_INT         = 79,
        CMD_GET_RDS_FREQ_INT         = 80,
        CMD_SET_RDS_FREQ_FRAC        = 81,
        CMD_GET_RDS_FREQ_FRAC        = 82,
        CMD_SET_RDS_READ_ADDR        = 83,
        CMD_GET_RDS_READ_ADDR        = 84,
        CMD_READ_TDC_FROM_URAM     = 85
        




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


//                            //CMD RO
//                            CMD_SET_RO_VAL: begin
//                                current_state           <= STATE_SET_RO_VAL;
//                                uart_rx_empty_buffer    <= 'b1;
//                            end

//                            CMD_GET_RO_VAL: begin
//                                current_state           <= STATE_GET_RO_VAL;
//                            end

//                            CMD_SET_RO_ID: begin
//                                current_state           <= STATE_SET_RO_ID;
//                                uart_rx_empty_buffer    <= 'b1;
//                            end

//                            CMD_GET_RO_ID: begin
//                                current_state           <= STATE_GET_RO_ID;
//                            end



//                            CMD_SET_RO_MEAS_TIME: begin
//                                current_state           <= STATE_SET_RO_MEAS_TIME;
//                                uart_rx_empty_buffer    <= 'b1;

//                            end

//                            CMD_GET_RO_MEAS_TIME: begin
//                                current_state           <= STATE_GET_RO_MEAS_TIME;
//                            end


                            // USER URAM CONTROL
                             CMD_SET_URAM_READ_ADDR: begin
                                current_state           <= STATE_SET_URAM_READ_ADDR;
                                uart_rx_empty_buffer    <= 'b1;

                            end

                            CMD_GET_URAM_READ_ADDR: begin
                                current_state           <= STATE_GET_URAM_READ_ADDR;
                            end
                           CMD_SET_URAM_WRITE_ADDR: begin
                                current_state           <= STATE_SET_URAM_WRITE_ADDR;
                                uart_rx_empty_buffer    <= 'b1;

                            end

                            CMD_GET_URAM_WRITE_ADDR: begin
                                current_state           <= STATE_GET_URAM_WRITE_ADDR;
                            end

                            CMD_WRITE_URAM_DATA: begin
                                current_state           <= STATE_WRITE_URAM_DATA;
                                uart_rx_empty_buffer    <= 'b1;

                            end

                            CMD_READ_URAM_DATA: begin
                                current_state           <= STATE_READ_URAM_DATA;
                            end


                            /// CMD for TDC

                            CMD_GET_TDC_VAL: begin
                                current_state           <= STATE_GET_TDC_VAL;
                            end
                            CMD_SET_TDC_VAL: begin
                                current_state           <= STATE_SET_TDC_VAL;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_SET_TDC_ID: begin
                                current_state           <= STATE_SET_TDC_ID;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_GET_TDC_ID: begin
                                current_state           <= STATE_GET_TDC_ID;
                            end
                            CMD_SET_TDC_MEAS_CYCLE: begin
                                current_state           <= STATE_SET_TDC_MEAS_CYCLE;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_GET_TDC_MEAS_CYCLE: begin
                                current_state           <= STATE_GET_TDC_MEAS_CYCLE;
                            end
                            CMD_GET_MEAS_TDC: begin
                                current_state           <= STATE_GET_MEAS_TDC;
                            end
                            CMD_TRIG_MEAS_TDC: begin
                                current_state           <= STATE_TRIG_MEAS_TDC;
                            end
                            CMD_GET_COARSE_TUNE_TDC: begin
                                current_state           <= STATE_GET_COARSE_TUNE_TDC;
                            end
                            CMD_SET_COARSE_TUNE_TDC: begin
                                current_state           <= STATE_SET_COARSE_TUNE_TDC;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_GET_FINE_TUNE_TDC: begin
                                current_state           <= STATE_GET_FINE_TUNE_TDC;
                            end
                            CMD_SET_FINE_TUNE_TDC: begin
                                current_state           <= STATE_SET_FINE_TUNE_TDC;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_SET_TDC_FREQ_INT: begin
                                current_state           <= STATE_SET_TDC_FREQ_INT;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_GET_TDC_FREQ_INT: begin
                                current_state           <= STATE_GET_TDC_FREQ_INT;
                            end
                            CMD_SET_TDC_FREQ_FRAC: begin
                                current_state           <= STATE_SET_TDC_FREQ_FRAC;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_GET_TDC_FREQ_FRAC: begin
                                current_state           <= STATE_GET_TDC_FREQ_FRAC;
                            end
                            CMD_SET_TDC_READ_ADDR: begin
                                current_state           <= STATE_SET_TDC_READ_ADDR;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            CMD_GET_TDC_READ_ADDR: begin
                                current_state           <= STATE_GET_TDC_READ_ADDR;
                            end

                            CMD_SET_GPIO: begin
                                current_state           <= STATE_SET_GPIO;
                                uart_rx_empty_buffer    <= 'b1;
                            end

                            CMD_UNSET_GPIO: begin
                                current_state           <= STATE_UNSET_GPIO;
                                uart_rx_empty_buffer    <= 'b1;
                            end
                            
                            CMD_READ_TDC_FROM_URAM: begin
                                current_state           <= STATE_READ_TDC_FROM_URAM;
                            end


                            default: begin
                                current_state           <= STATE_TRANSITION_INPUT;
                                
                            end
                        endcase
                    end
                end







//                STATE_SET_RO_MEAS_TIME: begin
//                    if (uart_rx_updated_buffer) begin
//                        if (uart_rx_data_length >= 'd8) begin
//                           ro_meas_time[7:0] <= uart_rx_data[7];// data comes in big endian
//                           ro_meas_time[15:8] <= uart_rx_data[6];
//                           ro_meas_time[23:16] <= uart_rx_data[5];
//                           ro_meas_time[31:24] <= uart_rx_data[4];
//                           ro_meas_time[39:32] <= uart_rx_data[3];
//                           ro_meas_time[47:40] <= uart_rx_data[2];
//                           ro_meas_time[55:48] <= uart_rx_data[1];
//                           ro_meas_time[63:56] <= uart_rx_data[0];
//                           current_state     <= STATE_TRANSITION_INPUT;
//                        end
//                    end
//                end

//                STATE_GET_RO_MEAS_TIME: begin
//                    if (uart_tx_ready) begin
//                           uart_tx_data[7]<= ro_meas_time[7:0];  // data comes in big endian
//                            uart_tx_data[6]<=ro_meas_time[15:8] ;
//                            uart_tx_data[5]<=ro_meas_time[23:16];
//                             uart_tx_data[4]<=ro_meas_time[31:24];
//                             uart_tx_data[3]<=ro_meas_time[39:32];
//                             uart_tx_data[2]<=ro_meas_time[47:40];
//                             uart_tx_data[1]<=ro_meas_time[55:48];
//                             uart_tx_data[0]<=ro_meas_time[63:56];
//                        uart_tx_data_length <= 'd8;
//                        uart_tx_en          <= 'b1;
//                        current_state       <= STATE_TRANSITION_INPUT;
//                    end
//                end

//               STATE_EXEC_MEAS_RO: begin
//                       ro_counter_en        <= 1'b1;
//                        current_state       <= STATE_EXEC_MEAS_RO_POST;

//               end
//               STATE_EXEC_MEAS_RO_POST: begin
//                       ro_counter_en        <= 1'b0;
//                        current_state       <= STATE_TRANSITION_INPUT;

//               end


//                    STATE_GET_MEAS_RO: begin
//                    if (uart_tx_ready) begin
//                           uart_tx_data[7]<= ro_meas_count[ro_id_reg][7:0];  // data comes in big endian
//                            uart_tx_data[6]<=ro_meas_count[ro_id_reg][15:8] ;
//                            uart_tx_data[5]<=ro_meas_count[ro_id_reg][23:16];
//                             uart_tx_data[4]<=ro_meas_count[ro_id_reg][31:24];
//                             uart_tx_data[3]<=ro_meas_count[ro_id_reg][39:32];
//                             uart_tx_data[2]<=ro_meas_count[ro_id_reg][47:40];
//                             uart_tx_data[1]<=ro_meas_count[ro_id_reg][55:48];
//                             uart_tx_data[0]<=ro_meas_count[ro_id_reg][63:56];
//                        uart_tx_data_length <= 'd8;
//                        uart_tx_en          <= 'b1;
//                        current_state       <= STATE_TRANSITION_INPUT;
//                    end
//                end


                STATE_SET_GPIO: begin
                  led_temp <= 'b1;
                  uart_rx_empty_buffer    <= 'b1;
                  current_state   <= STATE_TRANSITION_INPUT;
                    
                end



//                STATE_SET_RO_ID: begin
//                if (uart_rx_updated_buffer) begin
//                    if (uart_rx_data_length >= 'd1) begin
//                       ro_id_reg <= uart_rx_data[0];
//                        current_state     <= STATE_TRANSITION_INPUT;
//                    end
//                end
//                end 


//               STATE_GET_RO_ID: begin
//                    if (uart_tx_ready) begin
////                        uart_tx_data[3] <= trigger_offset[7:0];
////                        uart_tx_data[2] <= trigger_offset[15:8];
////                        uart_tx_data[1] <= trigger_offset[23:16];
//                        uart_tx_data[0] <= ro_id_reg;
//                        uart_tx_data_length <= 'd1;
//                        uart_tx_en          <= 'b1;
//                        current_state       <= STATE_TRANSITION_INPUT;
//                    end
//                end

//                STATE_SET_RO_VAL: begin
//                    if (uart_rx_updated_buffer) begin
//                        if (uart_rx_data_length >= 'd1) begin
//                           ro_en[ro_id_reg] <= uart_rx_data[0]&1;
//                            current_state     <= STATE_TRANSITION_INPUT;
//                        end
//                    end
//                end




//                STATE_GET_RO_VAL: begin
//                    if (uart_tx_ready) begin
//                        uart_tx_data[0] <= {8{ro_en[ro_id_reg]}};
//                        uart_tx_data_length <= 'd1;
//                        uart_tx_en          <= 'b1;
//                        current_state       <= STATE_TRANSITION_INPUT;
//                    end
//                end


                //USER URAM STATES

                STATE_SET_URAM_READ_ADDR: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd2) begin
                           uram_addr_read[7:0] <= uart_rx_data[1];// data comes in big endian
                           uram_addr_read[15:8] <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end

                STATE_GET_URAM_READ_ADDR: begin
                    if (uart_tx_ready) begin
                           uart_tx_data[1]<= uram_addr_read[7:0];  // data comes in big endian
                            uart_tx_data[0]<=uram_addr_read[15:8] ;


                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end

                 STATE_SET_URAM_WRITE_ADDR: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd2) begin
                           uram_addr_write[7:0] <= uart_rx_data[1];// data comes in big endian
                           uram_addr_write[15:8] <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end

                STATE_GET_URAM_WRITE_ADDR: begin
                    if (uart_tx_ready) begin
                           uart_tx_data[1]<= uram_addr_write[7:0];  // data comes in big endian
                            uart_tx_data[0]<=uram_addr_write[15:8] ;


                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end


                 STATE_WRITE_URAM_DATA: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd1) begin
                           uram_din[7:0] <= uart_rx_data[0];// data comes in big endian
                          uram_write_mem <= 'b1;

                            current_state     <= STATE_URAM_POST_WRITE;
                        end
                    end
                end

                STATE_URAM_POST_WRITE: begin
                   uram_write_mem <= 'b0;
                    current_state   <= STATE_TRANSITION_INPUT;
                end

                STATE_READ_URAM_DATA: begin
                    if (uart_tx_ready) begin
                           uart_tx_data[0]<= uram_dout[7:0];  // data comes in big endian

                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
                
                // TDC STATES

                // Set TDC ID
                STATE_SET_TDC_ID: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd1) begin
                            tdc_id_reg <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end

                // Set TDC Value
                STATE_SET_TDC_VAL: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd1) begin
                            tdc_en[tdc_id_reg[TDC_INST-1:0]] <= uart_rx_data[0];
                            current_state     <= STATE_TRANSITION_INPUT;
                        end
                    end
                end
        
                // Set TDC Measurement Cycle
                STATE_SET_TDC_MEAS_CYCLE: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd2) begin
                            tdc_meas_cycle[7:0]  <= uart_rx_data[1];
                            tdc_meas_cycle[15:8] <= uart_rx_data[0];
                            current_state        <= STATE_TRANSITION_INPUT;
                        end
                    end
                end
        
                // Set Coarse Tune TDC
                STATE_SET_COARSE_TUNE_TDC: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= 'd4) begin
                            tdc_coarse_delay_id[7:0]   <= uart_rx_data[3];
                            tdc_coarse_delay_id[15:8]  <= uart_rx_data[2];
                            tdc_coarse_delay_id[23:16] <= uart_rx_data[1];
                            tdc_coarse_delay_id[31:24] <= uart_rx_data[0]; 
                            current_state              <= STATE_TRANSITION_INPUT;
                        end
                    end
                end
        
                // Set Fine Tune TDC
                STATE_SET_FINE_TUNE_TDC: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= FINE_WIDTH/8) begin
                            for (int i = 0; i < FINE_WIDTH/8; i++) begin
                                tdc_fine_delay_id[i*8 +: 8] <= uart_rx_data[FINE_WIDTH/8 - 1 - i];
                            end
                            current_state <= STATE_TRANSITION_INPUT;
                        end
                    end
                end
        
        

        
                // Set TDC Read Address
                STATE_SET_TDC_READ_ADDR: begin
                    if (uart_rx_updated_buffer) begin
                        if (uart_rx_data_length >= URAM_ADDRESS_MAX_WIDTH/8) begin
                            for (int i = 0; i < URAM_ADDRESS_MAX_WIDTH/8; i++) begin
                                tdc_addr_read[tdc_id_reg[TDC_INST-1:0]][i*8 +: 8] <= uart_rx_data[URAM_ADDRESS_MAX_WIDTH/8 - 1 - i];
                            end
                            current_state <= STATE_TRANSITION_INPUT;
                        end
                    end
                end
            
                        // Get TDC ID
                STATE_GET_TDC_ID: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0]     <= tdc_id_reg;
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
            
                // Get TDC Value
                STATE_GET_TDC_VAL: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[0]     <= {8{tdc_en[tdc_id_reg]}};;
                        uart_tx_data_length <= 'd1;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
            
                // Get TDC Measurement Cycle
                STATE_GET_TDC_MEAS_CYCLE: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[1]     <= tdc_meas_cycle[7:0];
                        uart_tx_data[0]     <= tdc_meas_cycle[15:8];
                        uart_tx_data_length <= 'd2;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
            
                // Get Coarse Tune TDC
                STATE_GET_COARSE_TUNE_TDC: begin
                    if (uart_tx_ready) begin
                        uart_tx_data[3]     <= tdc_coarse_delay_id[7:0];
                        uart_tx_data[2]     <= tdc_coarse_delay_id[15:8];
                        uart_tx_data[1]     <= tdc_coarse_delay_id[23:16];
                        uart_tx_data[0]     <= tdc_coarse_delay_id[31:24];     
                        uart_tx_data_length <= 'd4;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
            
                // Get Fine Tune TDC
                STATE_GET_FINE_TUNE_TDC: begin
                    if (uart_tx_ready) begin
                        for (int i = 0; i < FINE_WIDTH/8; i++) begin
                            uart_tx_data[i] <= tdc_fine_delay_id[(FINE_WIDTH/8 - 1 - i)*8 +: 8];
                        end
                        uart_tx_data_length <= FINE_WIDTH/8;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
            
            
                // Get TDC Read Address
                STATE_GET_TDC_READ_ADDR: begin
                    if (uart_tx_ready) begin
                        for (int i = 0; i < URAM_ADDRESS_MAX_WIDTH/8; i++) begin
                            uart_tx_data[i] <= tdc_addr_read[tdc_id_reg[TDC_INST-1:0]][(URAM_ADDRESS_MAX_WIDTH/8 - 1 - i)*8 +: 8];
                        end
                        uart_tx_data_length <= URAM_ADDRESS_MAX_WIDTH/8;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
            
                // Trigger TDC Measurement
                STATE_TRIG_MEAS_TDC: begin
                    tdc_trigger_en[tdc_id_reg[TDC_INST-1:0]]  <= 1'b1;
                    current_state   <= STATE_TRIG_MEAS_TDC_POST;
                end
            
                STATE_TRIG_MEAS_TDC_POST: begin
                    tdc_trigger_en[tdc_id_reg[TDC_INST-1:0]]  <= 1'b0;
                    current_state   <= STATE_TRANSITION_INPUT;
                end
            
                // Get Measurement Data from URAM
                STATE_GET_MEAS_TDC: begin
                    if (uart_tx_ready) begin
                        
                        for (int i = 0; i < SENSOR_WIDTH/8; i++) begin
                            uart_tx_data[i] <= tdc_out[tdc_id_reg[TDC_INST-1:0]][(SENSOR_WIDTH/8 - 1 - i)*8 +: 8];
                        end
                        uart_tx_data_length <= SENSOR_WIDTH/8;
                        uart_tx_en          <= 'b1;
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                end
                
                
                STATE_UNSET_GPIO: begin
                    led_temp            <= 'b0;
                    current_state       <= STATE_TRANSITION_INPUT;
                    
                end
            
    


                STATE_READ_TDC_FROM_URAM: begin
                    /////reading all bram data/////////////////////////
                    if (uart_tx_ready) begin
                        uart_tx_data[7]<= tdc_dout[it][7:0];  // data comes in big endian
                        uart_tx_data[6]<=tdc_dout[it][15:8] ;
                        uart_tx_data[5]<=tdc_dout[it][23:16];
                        uart_tx_data[4]<=tdc_dout[it][31:24];
                        uart_tx_data[3]<=tdc_dout[it][39:32];
                        uart_tx_data[2]<=tdc_dout[it][47:40];
                        uart_tx_data[1]<=tdc_dout[it][55:48];
                        uart_tx_data[0]<=tdc_dout[it][63:56];
                        uart_tx_data_length <= 'd8;
                        uart_tx_en          <= 'b1;
                        it <= it +1;
                        if(it >= 79) begin
                            it <= 0;
                        end                        
                        current_state       <= STATE_TRANSITION_INPUT;
                    end
                      
                    ////////////////////////////////////////////////////////////
    
                end
        
                STATE_TRANSITION_INPUT: begin
                    uart_rx_empty_buffer    <= 'b1;
                    current_state           <= STATE_INPUT;
                end
            endcase
        end
    end
endmodule