
module xadc_module(
    input  wire        clk,
    input  wire        rst,
    output wire [15:0]  temp,
    output wire [15:0]  vccint,
    output wire [15:0]  vccaux
);

    wire [4:0]  channel_out;
    wire        eoc_out;
    wire        drdy_out;
    wire [15:0] do_out;
    
    reg  [6:0]  daddr_in = 7'd0;
    reg         den_in   = 1'b0;
    reg         dwe_in   = 1'b0;
    reg  [15:0] di_in    = 16'd0;

    wire alarm_out, vccint_alarm_out;
    xadc_wiz_0 u_xadc (
        .daddr_in    (daddr_in),
        .dclk_in     (clk),
        .den_in      (den_in),
        .di_in       (di_in),
        .dwe_in      (dwe_in),
        .busy_out    (),
        .channel_out (channel_out),
        .do_out      (do_out),
        .drdy_out    (drdy_out),
        .eoc_out     (eoc_out),
        .eos_out     (),
        .vccint_alarm_out (vccint_alarm_out),
        .alarm_out  (alarm_out),
        .vp_in       (),
        .vn_in       ()
    );

    // Correct widths
    localparam [4:0] CH_TEMP   = 5'h00;
    localparam [4:0] CH_VCCINT = 5'h01;
    localparam [4:0] CH_VCCAUX = 5'h02;
    
    reg [4:0]  last_ch = 5'd0;
    reg [15:0] temp_code   = 16'd0;
    reg [15:0] vccint_code = 16'd0;
    reg [15:0] vccaux_code = 16'd0;

    // On EOC: request a DRP read of the correct status register
    always @(posedge clk) begin
    if (rst) begin
      den_in   <= 1'b0;
      daddr_in <= 7'd0;
      last_ch  <= 5'd0;
    end else begin
      den_in <= 1'b0; // default
    
      if (eoc_out) begin
        last_ch  <= channel_out;
    
        // Map channel to register address (TEMP=0, VCCINT=1, VCCAUX=2)
        // (This works for internal channels in the usual wizard config)
        daddr_in <= {2'b00, channel_out};  // 7-bit address
        den_in   <= 1'b1;                  // pulse read request
      end
    end
    end
    
    // On DRDY: latch the DRP read data
    always @(posedge clk) begin
    if (rst) begin
      temp_code   <= 16'd0;
      vccint_code <= 16'd0;
      vccaux_code <= 16'd0;
    end else if (drdy_out) begin
      case (last_ch)
        CH_TEMP:   temp_code   <= do_out;
        CH_VCCINT: vccint_code <= do_out;
        CH_VCCAUX: vccaux_code <= do_out;
        default: ;
      endcase
    end
    end
    
    assign temp   = temp_code;
    assign vccint = vccint_code;
    assign vccaux = vccaux_code;

endmodule