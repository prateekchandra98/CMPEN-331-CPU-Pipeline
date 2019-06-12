`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Pennsylvania State University
// Engineer: Prateek Chandra and Harrison Fesel 
// 
// Create Date: 11/10/2017 11:37:23 AM
// Design Name: 
// Module Name: control_unit
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


module control_unit(op, func, wreg, m2reg, wmem, aluc, aluimm, regrt);

    input [5:0] op;
    input [5:0] func;
    
    output reg [0:0] m2reg; 
    output reg [0:0] aluimm;
    output reg [0:0] regrt;
    
    output reg [0:0] wreg;
    output reg [0:0] wmem;
    
    output reg [3:0] aluc;
    
    always @ (op, func)
    begin
        case(op)
        6'b000000: //add, sub, and, or, xor, sll, srl, sra, jr
        begin
            m2reg <= 'b0;
            aluimm <= 'b0;
            regrt <= 'b0;
            wreg <= 'b1;
            wmem <= 'b0;
            case(func)
            6'b100000: //add
            begin
                aluc <=4'b0010;
            end
            6'b100010: //sub
            begin
                aluc <=4'b0110;
            end
            6'b100100: //and
            begin
                aluc <=4'b0000;
            end
            6'b100101: //or
            begin
                aluc <=4'b0001;
            end
            6'b100110: //xor
            begin
                aluc <=4'b0011;
            end
            6'b101010: //set on less than
            begin
                aluc <=4'b0111;
            end
            
            6'b000000: //sll
            begin
                aluc <=4'b0010;
            end
            
            6'b000010: //srl
            begin
                aluc <=4'd0010;
            end
            6'b000011: //sra
            begin
                aluc <=4'd0010;
            end
            
            6'b001000: //jr
            begin
                aluc <=4'd0010;
            end
            
            
            endcase
            
        end
        6'b001000: //addi
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        6'b001100: //andi
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        6'b001101: //ori
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        6'b001110: //xori
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        6'b100011: //loadword
        begin
            m2reg <= 'b1;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0010;
        end
        6'b101011: //storeword
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b0;
            wmem <= 'b1;
            aluc <= 'b0010;
        end
        6'b000100: //beq
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b0;
            wmem <= 'b0;
            aluc <= 'd1;
        end
        6'b000101: //bne
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b0;
            wmem <= 'b0;
            aluc <= 'd1;
        end
        6'b001111: //lui
        begin
            m2reg <= 'b1;
            aluimm <= 'b1;
            regrt <= 'b1;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        6'b000010: //j
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b0;
            wreg <= 'b0;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        6'b000011: //jal
        begin
            m2reg <= 'b0;
            aluimm <= 'b1;
            regrt <= 'b0;
            wreg <= 'b1;
            wmem <= 'b0;
            aluc <= 'b0;
        end
        default:
        begin
            m2reg <= 'b0;
            aluimm <= 'b0;
            regrt <= 'b0;
            wreg <= 'b0;
            wmem <= 'b0;
            aluc <= 'd15; //from the lecture slides (default to 15)
        end
        endcase
    end
endmodule
