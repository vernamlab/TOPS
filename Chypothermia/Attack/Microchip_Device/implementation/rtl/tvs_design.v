
module tvs_design(
    input  wire        clk,
    input  wire        rst,
    output wire temp_low,
    output wire temp_high,
    output wire [15:0] temp,
    output wire [15:0] vcc1_0p, 
    output wire [15:0] vcc1_8P,
    output wire [15:0] vcc2_5P
);
    wire        tvs_active;
    wire [1:0]  tvs_channel;
    wire [15:0] tvs_value;
    reg [15:0] temp_reg;
    reg [15:0] vcc1_0p_reg;
    reg [15:0] vcc1_8P_reg;
    reg [15:0] vcc2_5P_reg;
    wire valid; 
    tvs_module tvs_module_u(
        // Outputs
        .active(tvs_active),
        .channel(tvs_channel),
        .temp_high(temp_high),
        .temp_low(temp_low),
        .valid(valid),
        .value(tvs_value)
    );
        

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            temp_reg    <= 16'd0;
            vcc1_0p_reg <= 16'd0;
            vcc1_8P_reg <= 16'd0;
            vcc2_5P_reg <= 16'd0;
        end else begin
            if (valid) begin
                case (tvs_channel)
                    2'd0: vcc1_0p_reg <= tvs_value;
                    2'd1: vcc1_8P_reg <= tvs_value;
                    2'd2: vcc2_5P_reg <= tvs_value;
                    2'd3: temp_reg    <= tvs_value;
                    default: begin
                        temp_reg    <= temp_reg;
                        vcc1_0p_reg <= vcc1_0p_reg;
                        vcc1_8P_reg <= vcc1_8P_reg;
                        vcc2_5P_reg <= vcc2_5P_reg;
                    end
                endcase
            end
        end
    end

    assign temp    = temp_reg;
    assign vcc1_0p = vcc1_0p_reg;
    assign vcc1_8P = vcc1_8P_reg;
    assign vcc2_5P = vcc2_5P_reg;

endmodule


