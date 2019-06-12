`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel
// 
// Create Date: 11/10/2017 11:37:40 AM
// Design Name: 
// Module Name: CPU
// Project Name: Final Project
// Target Devices: Zybo Board (XC7Z010-1CLG400C)
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

module CPU(clk, reset, LEDcheck); //, PC, IF_ID, ID_EXE, EXE_MEM, MEM_WB, wMUXoutOutput, w_MUX_32_out_Output);

    input clk;
    input reset;
    output reg LEDcheck;
     
    reg [31:0] PC;
    reg [31:0] IF_ID;
    reg [108:0] ID_EXE;
    reg [71:0] EXE_MEM;
    reg [70:0] MEM_WB;
    reg [4:0] wMUXoutOutput;
    reg [31:0] w_MUX_32_out_Output;
    
    //temporary
    wire [31:0] PC_wire;
    wire [31:0] IF_ID_wire;
    reg [108:0] ID_EXE_reg;
    reg [71:0] EXE_MEM_reg;
    reg [70:0] MEM_WB_reg;
    
//-------------------Instruction Fetch----------------------------------------
    
    PC_adder pcadd(
        .inputPC(PC),
        .outputPC(PC_wire)
    );
        
    instruction_module instmd(
        .PC(PC),
        .data_out(IF_ID_wire)
    );
    
//-------------------Instruction Decode----------------------------------------
    
    //----------inputs-------------
    reg [5:0] op,func;
    reg [4:0] rd, rs, rt, shamt;
    reg [15:0] imm ;
    
    //----------outputs------------
    
    //output of the sign extension
    wire [31:0] immext;
    //output of data register
    wire [31:0] qa, qb;
    //control unit
    wire [0:0] wreg, m2reg, wmem, aluimm, regrt;
    wire [3:0] aluc;
    //output of the mux
    wire [4:0] MUXout;
    
    //-------Outputs of Writeback-------
    reg wwreg;
    reg [4:0] wMUXout;
    wire [31:0] w_MUX_32_out;
    
    //output of the mux
    reg [4:0] mMUXout;
    //output of the mux
    reg [4:0] eMUXout;
    
    always @(IF_ID)
    begin
        op <= IF_ID [31:26];
        rs <= IF_ID [25:21];
        rt <= IF_ID [20:16];
        rd <= IF_ID [15:11];
        func <= IF_ID [5:0];
        imm <= IF_ID [15:0];
    end
    
    control_unit cunit(
        .op(op),
        .func(func), 
        .m2reg(m2reg), 
        .aluimm(aluimm),
        .regrt(regrt),
        .wreg(wreg),
        .wmem(wmem),
        .aluc(aluc)
    );
    mux2x1 mux(
        .Input0(rd),
        .Input1(rt),
        .selector(regrt),
        .D(MUXout)
    );
    register_file reg_file(
        .clk(clk),
        .Read1(rs), 
        .Read2(rt), 
        .Data1(qa), 
        .Data2(qb),
        .writeEnabled(wwreg),
        .writeData(w_MUX_32_out),
        .writeAddress(wMUXout)
    );
    signext_16_32 signext(
        .I(imm),
        .O(immext)
    );
    always @(wreg, m2reg, wmem, aluc, aluimm, MUXout, qa, qb, immext)
    begin
        ID_EXE_reg [108] <= wreg; //1 bit
        ID_EXE_reg [107] <= m2reg; //1 bit
        ID_EXE_reg [106] <= wmem; //1 bit
        ID_EXE_reg [105:102] <= aluc; //4 bits
        ID_EXE_reg [101] <= aluimm; //1 bit
        ID_EXE_reg [100: 96] <= MUXout; //5 bits
        ID_EXE_reg [95:64] <= qa; //32 bits
        ID_EXE_reg [63:32] <= qb; //32 bits
        ID_EXE_reg [31:0] <= immext; //32 bits 

    end
    
//-------------------Instruction Execute----------------------------------------
    
    //------Inputs---------
    //output of the sign extension f
    reg [31:0] eimmext;
    //output of data register
    reg [31:0] eqa, eqb;
    //control unit
    reg [0:0] ewreg, em2reg, ewmem, ealuimm;
    reg [3:0] ealuc;
    
    //-------Outputs---------
    wire [31:0] MUX_32_out;
    wire [31:0] ALU_Out;
    
    always @(ID_EXE)
    begin
        ewreg <= ID_EXE [108]; //1 bit
        em2reg <= ID_EXE [107] ; //1 bit
        ewmem <= ID_EXE [106]; //1 bit
        ealuc <= ID_EXE [105:102]; //4 bits
        ealuimm <= ID_EXE [101]; //1 bit
        eMUXout <= ID_EXE [100: 96] ; //5 bits
        eqa <= ID_EXE [95:64]; //32 bits
        eqb <= ID_EXE [63:32]; //32 bits
        eimmext <= ID_EXE [31:0]; //32 bits
    end
    
    emux2x1 emux(
        .Input0(eqb),
        .Input1(eimmext),
        .selector(ealuimm),
        .D(MUX_32_out)
    );
    
    ALU alu(
        .A(eqa),
        .B(MUX_32_out), 
        .aluc(ealuc),
        .ALUOut(ALU_Out)
    );
    
    always @(ewreg, em2reg, ewmem, eMUXout, ALU_Out, eqb)
    begin
        EXE_MEM_reg [71] <= ewreg;
        EXE_MEM_reg [70] <= em2reg;
        EXE_MEM_reg [69] <= ewmem;
        EXE_MEM_reg [68:64] <= eMUXout;
        EXE_MEM_reg [63:32] <= ALU_Out;
        EXE_MEM_reg [31:0] <= eqb;
    end
//------------------------Memory----------------------------------------
    
    //------Inputs---------
    //output of data register
    reg [31:0] mqb;
    //control unit
    reg mwreg, mm2reg, mwmem;
    //output of the alu
    reg [31:0] mALUout;
    //------Outputs---------
    wire [31:0] mDataOut;
    
    always @(EXE_MEM)
    begin
        mwreg <= EXE_MEM[71];
        mm2reg <= EXE_MEM[70];
        mwmem <= EXE_MEM[69] ;
        mMUXout <= EXE_MEM[68:64];
        mALUout <= EXE_MEM[63:32];
        mqb <= EXE_MEM[31:0];
    end
    
    data_mem dataMem(
        .address(mALUout),
        .dataIn(mqb),
        .writeEnabled(mwmem),
        .dataOut(mDataOut)
    );
    
    always @(mwreg, mm2reg, mMUXout, mALUout, mqb, mDataOut)
    begin
        MEM_WB_reg [70] <= mwreg;
        MEM_WB_reg [69] <= mm2reg;
        MEM_WB_reg [68:64] <= mMUXout;
        MEM_WB_reg [63:32] <= mALUout;
        MEM_WB_reg [31:0] <= mDataOut;
    end
    
    //-------------------Write Back----------------------------------------
    reg wm2reg;
    reg [31:0] wALUout;
    reg [31:0] wDataOut;
    
    always @(MEM_WB)
    begin
        wwreg <= MEM_WB [70];
        wm2reg <= MEM_WB [69];
        wMUXout <= MEM_WB [68:64];
        wALUout <= MEM_WB [63:32];
        wDataOut <= MEM_WB [31:0];
    end
    
    wmux2x1 wmux(
        .Input0(wALUout),
        .Input1(wDataOut),
        .selector(wm2reg),
        .D(w_MUX_32_out)
    );
    
    reg [31:0] count;
    
    initial
    begin
        count <= 'd100;
    end
    
    always @(posedge clk)
    begin
        if (reset == 'd1)
        begin
            if (count > 'h90)
            begin
                LEDcheck <= 'b1;
            end
            //increment alond with PC (without stalls) to determine the end time of instructions
            count <= count+'h4;        
            if (eMUXout == rs || eMUXout == rt || mMUXout == rs || mMUXout == rt)
            begin
                if (eMUXout == rs || eMUXout == rt)
                begin
                    ID_EXE <= 'dX;
                    EXE_MEM <= EXE_MEM_reg;
                    MEM_WB <= MEM_WB_reg;
                    wMUXoutOutput <= wMUXout;
                    w_MUX_32_out_Output <= w_MUX_32_out;
                end
                if (mMUXout == rs || mMUXout == rt)
                begin
                    EXE_MEM <= 'dX;
                    MEM_WB <= MEM_WB_reg;
                    wMUXoutOutput <= wMUXout;
                    w_MUX_32_out_Output <= w_MUX_32_out;
                end
            end
            else
            begin
                PC <= PC_wire;
                IF_ID <= IF_ID_wire;
                ID_EXE <= ID_EXE_reg;
                EXE_MEM <= EXE_MEM_reg;
                MEM_WB <= MEM_WB_reg;
                wMUXoutOutput <= wMUXout;
                w_MUX_32_out_Output <= w_MUX_32_out;
            end
                
        end 
        else
        begin
            PC <= 32'd100;
            LEDcheck <= 'b0;
        end
    end
    
endmodule
