`timescale 1 ns/100 ps
// Version: 2025.2 2025.2.0.14


module PF_OSC_C0_PF_OSC_C0_0_PF_OSC(
       RCOSC_2MHZ_GL
    );
output RCOSC_2MHZ_GL;

    wire GND_net, VCC_net, I_OSC_2_CLK_c;
    
    CLKINT I_OSC_2_INT (.A(I_OSC_2_CLK_c), .Y(RCOSC_2MHZ_GL));
    VCC vcc_inst (.Y(VCC_net));
    OSC_RC2MHZ I_OSC_2 (.OSC_2MHZ_ON(VCC_net), .CLK(I_OSC_2_CLK_c));
    GND gnd_inst (.Y(GND_net));
    
endmodule
