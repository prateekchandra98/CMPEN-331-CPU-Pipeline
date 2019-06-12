`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/10/2017 11:40:42 AM
// Design Name: 
// Module Name: register_file
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


module register_file(clk, Read1, Read2, Data1, Data2, writeEnabled, writeData, writeAddress);

    input clk;
    input [4:0] writeAddress;
    input [31:0] writeData;
    input writeEnabled;
    input [4:0] Read1, Read2;//the registers number to read
    output reg [31:0] Data1, Data2;
    reg[31:0] RF[0:31];
    integer i;
    initial
    begin
        
        RF[0] <= 'h00000000;
        RF[1] <= 'hA00000AA;
        RF[2] <= 'h10000011;
        RF[3] <= 'h20000022;
        RF[4] <= 'h30000033;
        RF[5] <= 'h40000044;
        RF[6] <= 'h50000055;
        RF[7] <= 'h60000066;
        RF[8] <= 'h70000077;
        RF[9] <= 'h80000088;
        RF[10] <= 'h90000099;
        
        
    end
    
    always @ (negedge clk)
    begin
        Data1 <= RF[Read1];
        Data2 <= RF[Read2];
    end
    
    always @(*) //happens right after positive clock edge
    begin 
        if (writeEnabled)
        begin
            RF[writeAddress] <= writeData;
        end
    end
    
 
endmodule
