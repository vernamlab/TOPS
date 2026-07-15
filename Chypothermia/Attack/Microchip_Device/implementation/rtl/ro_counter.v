module ro_counter #(
    parameter N = 32                
)(
    input  wire clk,                
    input  wire ro_count_en,         
    input  wire ro_out,        
    output reg  [N-1:0] counter 
);

    reg [16:0] clk_cnt;
    reg [N-1:0] edge_count;      
    
    reg en_counting;

    always @(posedge clk) begin
        if (ro_count_en==1'b0) begin
            clk_cnt    <= 17'd0; 
            en_counting <= 1'b0;
            counter    <= {N{1'b0}};
        end else begin
             en_counting <= 1'b1;
            if (clk_cnt == 17'd100000 - 1) begin
                counter    <= edge_count ;
                en_counting    <= 1'b0; 
                clk_cnt <= 17'd0;  
            end else begin
                clk_cnt <= clk_cnt + 1'b1;
            end
        end
    end
    
    always @(posedge ro_out) begin
        if (!en_counting) begin
            edge_count <= {N{1'b0}};
        end else begin
            edge_count <= edge_count + 1'b1;
        end
    end

endmodule

