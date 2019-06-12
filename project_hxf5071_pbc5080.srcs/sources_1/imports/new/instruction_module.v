`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel
// 
// Create Date: 11/10/2017 11:38:48 AM
// Design Name: 
// Module Name: instruction_module
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


module instruction_module(PC, data_out);
    
    input [31:0] PC;
    output reg [31:0] data_out;
    
    reg [8:0] instruction_memory [0:1023];
    
    //add
    parameter [31:0] instruction1 = 32'b00000000001000100001100000100000;
    //sub
    parameter [31:0] instruction2 = 32'b00000001001000110001000000100010;
    //or
    parameter [31:0] instruction3 = 32'b00000000011010010010100000100101;
    //xor
    parameter [31:0] instruction4 = 32'b00000000011010010011000000100110;
    //and
    parameter [31:0] instruction5 = 32'b00000000011010010011100000100100;
    //initializing the instruction memory
    initial
    begin
        instruction_memory [100] <= instruction1[31:24];
        instruction_memory [101] <= instruction1[23:16];
        instruction_memory [102] <= instruction1[15:8];
        instruction_memory [103] <= instruction1[7:0];
        
        instruction_memory [104] <= instruction2[31:24];
        instruction_memory [105] <= instruction2[23:16];
        instruction_memory [106] <= instruction2[15:8];
        instruction_memory [107] <= instruction2[7:0];
        
        instruction_memory [108] <= instruction3[31:24];
        instruction_memory [109] <= instruction3[23:16];
        instruction_memory [110] <= instruction3[15:8];
        instruction_memory [111] <= instruction3[7:0];
        
        instruction_memory [112] <= instruction4[31:24];
        instruction_memory [113] <= instruction4[23:16];
        instruction_memory [114] <= instruction4[15:8];
        instruction_memory [115] <= instruction4[7:0];   
        
        instruction_memory [116] <= instruction5[31:24];
        instruction_memory [117] <= instruction5[23:16];
        instruction_memory [118] <= instruction5[15:8];
        instruction_memory [119] <= instruction5[7:0];
        
    end
    
    always @(PC)
    begin
        data_out[31:24] <= instruction_memory [PC];
        data_out[23:16] <= instruction_memory [PC+1];
        data_out[15:8] <= instruction_memory [PC+2];
        data_out[7:0] <= instruction_memory [PC+3];
    end

endmodule
