`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/10/2017 11:39:16 AM
// Design Name: 
// Module Name: mux2x1
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


module mux2x1(Input1, Input0, selector, D);
   
   input [4:0] Input1, Input0;
   input selector;
   output reg [4:0] D;

   always @(Input1, Input0, selector)
   begin
      if (!selector) begin
         D <= Input0;
      end
      else begin
         D <= Input1;
      end
   end
   
endmodule
