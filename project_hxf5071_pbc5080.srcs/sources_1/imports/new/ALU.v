`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel
// 
// Create Date: 11/11/2017 04:36:15 PM
// Design Name: 
// Module Name: ALU
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


module ALU(A, B, aluc, ALUOut);
    input [31:0] A, B;
    input [3:0] aluc;
    output reg [31:0] ALUOut;
    
    always @(A, B, aluc)
    begin
        case (aluc)
            'd0: ALUOut[31:0] <= A&B; //and
            'd1: ALUOut[31:0] <= A|B; //or
            'd2: ALUOut[31:0] <= A+B; //add
            'd3: ALUOut[31:0] <= A^B; //xor
            'd6: ALUOut[31:0] <= A-B; //sub
            'd7: ALUOut[31:0] <= A<B?1:0; //set if less than
            'd12: ALUOut[31:0] <= ~(A|B);  //nor
            default ALUOut <= 'bX; //from the lecture slides
        endcase
    end
endmodule
