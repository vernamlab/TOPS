module sys_mon(
    input  wire        clk,
    input  wire        rst,

    output wire   [15:0] vccint,       
    output signed [15:0] temperature,  
    output wire   [15:0] vccaux
);

  wire [5:0]  channel_out;      
  wire        busy_out;
  wire        eoc_out;
  wire        eos_out;
  wire        alarm_out;
  wire [15:0] adc_data_master;

  system_management_wiz_0 sysmon_u (
    .dclk_in         (clk),
    .busy_out        (busy_out),
    .channel_out     (channel_out),
    .eoc_out         (eoc_out),
    .eos_out         (eos_out),
    .adc_data_master (adc_data_master),
    .alarm_out       (alarm_out)
  );

  localparam [5:0] CH_TEMP   = 6'h00;
  localparam [5:0] CH_VCCINT = 6'h01;
  localparam [5:0] CH_VCCAUX = 6'h02;

  reg [15:0] temp_code   = 16'd0;
  reg [15:0] vccint_code = 16'd0;
  reg [15:0] vccaux_code = 16'd0;

  always @(posedge clk) begin
    if (rst) begin
      temp_code   <= 16'd0;
      vccint_code <= 16'd0;
      vccaux_code <= 16'd0;
    end
    else if (eoc_out) begin
      case (channel_out)
        CH_TEMP:   temp_code   <= adc_data_master;
        CH_VCCINT: vccint_code <= adc_data_master;
        CH_VCCAUX: vccaux_code <= adc_data_master;
        default: ; // ignore other channels
      endcase
    end
  end   
  
  assign temperature = temp_code;
  assign vccint      = vccint_code;
  assign vccaux      = vccaux_code;

endmodule







