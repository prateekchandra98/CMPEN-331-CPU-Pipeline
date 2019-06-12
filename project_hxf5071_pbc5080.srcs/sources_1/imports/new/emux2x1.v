`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/10/2017 03:15:55 PM
// Design Name: 
// Module Name: emux2x1
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


module emux2x1(Input1, Input0, selector, D);
   
    input [31:0] Input1, Input0;
    input selector;
    output reg [31:0] D;

    always @(Input1, Input0, selector)
    begin
      if (selector==1) 
      begin
         D <= Input1;
      end
      else 
      begin
         D <= Input0;
      end
    end
endmodule
