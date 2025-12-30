`timescale 1ns/1ps

module IIR_butterworth_3rd_order ( input clk, input rst_n, input signed [15:0]x_n, output reg signed [15:0]y_n );

    localparam signed [15:0]g = 16'sd229, b0_1 = 16'sd16384, b1_1 = 16'sd16384, a0_1 = -16'sd8980; //1st order filter
    localparam signed [15:0]b0_2 = 16'sd16384, b1_2 = 16'sd32767, b2_2 = 16'sd16384, a0_2 = -16'sd21768, a1_2 = 16'sd9438; //2nd order filter
    
    reg signed [15:0]xg, x_g_1, y1_n, y1_n_1, y1_n_2, y_n_1, y_n_2, y_out;
    reg signed [31:0]acc1, acc2; 
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            x_g_1 <= 0;
            y1_n <= 0;
            y1_n_1 <= 0;
            y1_n_2 <= 0;
            y_n_1 <= 0;
            y_n_2 <= 0;
            xg <= 0;
            acc1 <= 0;
            acc2 <= 0;
            y_out <= 0;
            y_n <= 0;
        end
        else begin
            acc1 = g*x_n;
            xg = acc1 >>> 14;
            
            acc1 = b0_1*xg + b1_1*x_g_1 - a0_1*y1_n_1;
            y1_n = acc1 >>> 14;
            
            acc2 = b0_2*y1_n + b1_2*y1_n_1 + b2_2*y1_n_2 - a0_2*y_n_1 -a1_2*y_n_2;
            y_out = acc2 >>> 14;
            
            x_g_1 <= xg;
            y1_n_1 <= y1_n;
            y1_n_2 <= y1_n_1;
            y_n_1 <= y_out;
            y_n_2 <= y_n_1; 
            
            y_n <= y_out;        
         end
     end         
endmodule