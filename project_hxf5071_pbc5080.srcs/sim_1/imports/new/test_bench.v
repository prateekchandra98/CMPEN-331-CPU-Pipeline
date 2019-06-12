`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/10/2017 11:48:03 AM
// Design Name: 
// Module Name: test_bench
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


module test_bench();
    reg clk;
    reg reset;
    wire LEDcheck;
    /**
    wire [31:0] PC;
    wire [31:0] IF_ID;
    wire [108:0] ID_EXE;
    wire [71:0] EXE_MEM;
    wire [70:0] MEM_WB;
    wire [4:0] wMUXoutOutput;
    wire [31:0] w_MUX_32_out_Output;
    **/
    CPU CPU1(
        .clk(clk), 
        .reset(reset), 
        .LEDcheck(LEDcheck)
        /**
        .IF_ID(IF_ID), 
        .ID_EXE(ID_EXE),
        .EXE_MEM(EXE_MEM),
        .MEM_WB(MEM_WB),
        .wMUXoutOutput(wMUXoutOutput),
        .w_MUX_32_out_Output(w_MUX_32_out_Output)
       **/ 
    );
    
    initial
    begin
        clk <= 'b1;
        reset <= 'b0;   
        #5 reset <= 'b1;
    end
    
    always
    begin
        #10 clk <= ~clk;
    end
    

endmodule

