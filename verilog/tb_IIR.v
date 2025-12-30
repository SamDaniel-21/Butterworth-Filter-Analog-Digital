`timescale 1ns/1ps

module tb_IIR();
    
    reg clk;
    reg rst_n;
    reg signed [15:0]x_n;
    wire signed [15:0]y_n;
    integer fd;// file object for data logging
    
    IIR_butterworth_3rd_order IIR1 ( .clk(clk), .rst_n(rst_n), .x_n(x_n), .y_n(y_n) );
    
    task sine_test; 
        integer i,j;
        reg signed [15:0] sine_lut [0:31];
        begin
            //One cycle sine LUT (Q2.14)
            sine_lut[0]  = 0;
            sine_lut[1]  = 3212;
            sine_lut[2]  = 6393;
            sine_lut[3]  = 9512;
            sine_lut[4]  = 12539;
            sine_lut[5]  = 15446;
            sine_lut[6]  = 18205;
            sine_lut[7]  = 20788;
            sine_lut[8]  = 23170;
            sine_lut[9]  = 25329;
            sine_lut[10] = 27245;
            sine_lut[11] = 28903;
            sine_lut[12] = 30289;
            sine_lut[13] = 31390;
            sine_lut[14] = 32195;
            sine_lut[15] = 32767;
            sine_lut[16] = 0;
            sine_lut[17] = -3212;
            sine_lut[18] = -6393;
            sine_lut[19] = -9512;
            sine_lut[20] = -12539;
            sine_lut[21] = -15446;
            sine_lut[22] = -18205;
            sine_lut[23] = -20788;
            sine_lut[24] = -23170;
            sine_lut[25] = -25329;
            sine_lut[26] = -27245;
            sine_lut[27] = -28903;
            sine_lut[28] = -30289;
            sine_lut[29] = -31390;
            sine_lut[30] = -32195;
            sine_lut[31] = -32767;

            for (i = 0;i < 16; i = i + 1) begin
                for (j = 0;j < 32; j = j + 1) begin
                    x_n = sine_lut[j] >>> 1; //half amplitude
                    #20;
                    $fwrite(fd,"%d,%d\n",x_n,y_n);//after clock pulse
                end
            end
            x_n = 0;
            $fwrite(fd,"%d,%d\n",x_n,y_n);
            #2000;
        end
    endtask
    
    initial begin
        clk = 1'b0;
        forever begin
            #10 clk = ~clk;
        end
    end
    
    initial begin
        
        fd = $fopen("IIR_data.csv","w");
        $fwrite(fd,"x_n,y_n\n");
    end
    
    initial begin
    
        $monitor("%d %d",x_n,y_n);
        
        rst_n = 1'b0;
        x_n = 0;
        
        #100;
        rst_n = 1'b1;
        
        //SINUSOIDAL RESPONSE
        sine_test;
        
        $stop;
    end
    
    initial begin
        #1000000;
        $fclose(fd);
    end
           
endmodule