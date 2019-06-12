`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/20/2017 04:04:55 PM
// Design Name: 
// Module Name: wmux2x1
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


module wmux2x1(Input1, Input0, selector, D);
   
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
