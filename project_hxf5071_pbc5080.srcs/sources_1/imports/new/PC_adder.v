`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/10/2017 11:40:00 AM
// Design Name: 
// Module Name: PC_adder
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


module PC_adder(inputPC, outputPC);
    
    input [31:0] inputPC;
    output reg [31:0] outputPC;
    
    parameter [31:0] INCREMENT_AMOUNT = 32'd4;
    
    initial
    begin
        outputPC <= 'd100;
    end
         
    always @ (inputPC) 
    begin
        outputPC <= inputPC + INCREMENT_AMOUNT;    
    end
    
endmodule
