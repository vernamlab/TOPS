module bram_module #(
    parameter AWIDTH = 20,  // Address Width
    parameter DWIDTH = 64,  // Data Width     ////////////////////

    parameter NBPIPE = 3)
( 
    input clk,                    // Clock 
    input wea,                    // Write Enable
    input mem_en,                 // Memory Enable
    input [DWIDTH-1:0] dina,      // Data Input  
    input [AWIDTH-1:0] addra,     // Write Address
    input [AWIDTH-1:0] addrb,     // Read  Address
    output reg [DWIDTH-1:0] doutb // Data Output
);

    reg [AWIDTH-1:0] ram [DWIDTH-1:0];
    reg [AWIDTH-1:0] dob;

    always @(posedge clk) begin
        if (mem_en) begin
            if (wea)
                ram[addra] <= dina;
            end
        end
            
        always @(posedge clk) begin
            if (mem_en) begin
                doutb <= ram[addrb];
        end
    end

endmodule