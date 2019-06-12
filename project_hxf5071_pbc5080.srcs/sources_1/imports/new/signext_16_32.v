`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel
// 
// Create Date: 11/10/2017 11:41:10 AM
// Design Name: 
// Module Name: signext_16_32
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


module signext_16_32(I, O);

    input [15:0] I;
    output reg [31:0] O;
    
    always @(I) 
    begin
        O <={{16{I[15]}}, I[15:0]};
    end
   
endmodule
