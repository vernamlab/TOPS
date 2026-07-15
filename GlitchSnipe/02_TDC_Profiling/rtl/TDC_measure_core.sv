`timescale 1ns / 1ps

module TDC_measure_core               #(parameter integer tdc_meas_size = 16,
        parameter integer tdc_width_size=64 ,    ////////////////
        parameter integer tdc_address_width_size = 20
     )(
        input logic[tdc_meas_size-1:0] tdc_meas_time  ,
        input logic tdc_clk           ,
        input logic[tdc_width_size-1:0] tdc_out        ,  
        input logic tdc_trigger_en       , // Input
        output logic ram_write_flag       , //Output 
        output logic[tdc_width_size-1:0] data_to_ram        , // Output
        output logic[tdc_address_width_size-1:0] ram_write_address    //Output
   );
    
    
    logic [tdc_meas_size-1:0] clk_temp_counter;

    logic measure_flag;

    typedef enum logic [1:0] {
        IDLE   = 2'b00,
        MEASURE = 2'b01,
        OUT_READY = 2'b10,
        RST_VALS = 2'b11

    } state_t;

    state_t current_state, next_state;
    initial next_state <= IDLE;
    // State transition logic
    always_ff @(negedge tdc_clk ) begin
            current_state <= next_state;
    end

    // Next state logic
    always @(posedge tdc_clk) begin
        case (current_state)
            IDLE: begin
            for (int i = 0; i < tdc_meas_size; i++) begin
                clk_temp_counter[i]         = 1'b0;
            end
                if (tdc_trigger_en) begin
                    next_state = RST_VALS;
                end else begin
                    next_state = IDLE;
                end
            end
            
              RST_VALS: begin
                next_state = MEASURE;
            
            end
                      
            MEASURE: begin
                if (clk_temp_counter < tdc_meas_time) begin
                    clk_temp_counter = clk_temp_counter+ ('d1);      
                    next_state = MEASURE;
                end else begin
                    for (int i = 0; i < tdc_meas_size; i++) begin
                        clk_temp_counter[i]         = 1'b0;
                    end
                    next_state = OUT_READY;
                end
            end
            
            OUT_READY: begin
                next_state = IDLE;
            
            end

//            default: begin
//                next_state = IDLE;
//            end
        endcase
    end

    
   always @( posedge tdc_clk  ) begin

       if(current_state==MEASURE) begin
           ram_write_flag <=1'b1;
           ram_write_address <=clk_temp_counter;
           data_to_ram <= tdc_out;

        end else if(current_state==OUT_READY) begin
            ram_write_flag      <=1'b0;

        end else if(current_state==RST_VALS) begin
             ram_write_flag      <=1'b0;

     
        end
    end
         

endmodule
