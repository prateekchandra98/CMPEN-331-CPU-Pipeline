`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel
// 
// Create Date: 11/10/2017 11:41:58 AM
// Design Name: 
// Module Name: data_mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_mem (writeEnabled, address, dataIn, dataOut);
       
    input writeEnabled; 
    input [31:0] address;
    input [31:0]dataIn;   
    output reg [31:0] dataOut; 
    
    reg[7:0] dataMemory[0:31];
    
    initial
    begin
        dataMemory[0] <= 'hA0;
        dataMemory[1] <= 'h00;
        dataMemory[2] <= 'h00;
        dataMemory[3] <= 'hAA;
        
        dataMemory[4] <= 'h10;
        dataMemory[5] <= 'h00;
        dataMemory[6] <= 'h00;
        dataMemory[7] <= 'h11;
        
        dataMemory[8] <= 'h20;
        dataMemory[9] <= 'h00;
        dataMemory[10] <= 'h00;
        dataMemory[11] <= 'h22;
        
        dataMemory[12] <= 'h30;
        dataMemory[13] <= 'h00;
        dataMemory[14] <= 'h00;
        dataMemory[15] <= 'h33;
        
        dataMemory[16] <= 'h40;
        dataMemory[17] <= 'h00;
        dataMemory[18] <= 'h00;
        dataMemory[19] <= 'h44;
        
        dataMemory[20] <= 'h50;
        dataMemory[21] <= 'h00; 
        dataMemory[22] <= 'h00; 
        dataMemory[23] <= 'h55;
        
        dataMemory[24] <= 'h60;
        dataMemory[25] <= 'h00; 
        dataMemory[26] <= 'h00; 
        dataMemory[27] <= 'h66;
        
        dataMemory[28] <= 'h70;
        dataMemory[29] <= 'h00; 
        dataMemory[30] <= 'h00; 
        dataMemory[31] <= 'h77; 
             
        dataMemory[32] <= 'h80;
        dataMemory[33] <= 'h00;
        dataMemory[34] <= 'h00;
        dataMemory[35] <= 'h88;
        
        dataMemory[36] <= 'h90;
        dataMemory[37] <= 'h00;
        dataMemory[38] <= 'h00;
        dataMemory[39] <= 'h99;
    end
    
    always @(address, writeEnabled)
    begin
        if (writeEnabled == 0)
        begin
            //load word
            dataOut[31:24] <= dataMemory [address];
            dataOut[23:16] <= dataMemory [address+1];
            dataOut[15:8] <= dataMemory [address+2];
            dataOut[7:0] <= dataMemory [address+3];
        end
        else
        begin
            //store word
            dataMemory [address] <= dataIn[31:24];
            dataMemory [address+1] <= dataIn [23:16];
            dataMemory [address+2] <= dataIn [15:8];
            dataMemory [address+3] <= dataIn [7:0];
        end
    end

endmodule
