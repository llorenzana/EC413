`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 01:55:26 PM
// Design Name: 
// Module Name: NbitRegAdd
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


module NbitRegAdd #(parameter N = 32)(
    output c_out,
    output [N-1:0] sum, 
    input  [N-1:0] a,
    input  [N-1:0] b,
    input  c_in, 
    input select,
    input  clk
 );
    
    wire [N-1:0] sum_adder;
    wire [N-1:0] sum_select; 
    wire c_adder; 
    wire [N-1:0] not_a_out; 
    
    NbitAdder #(.N(N)) Adder (.c_out(c_adder), .sum(sum_adder), .a(a), .b(b), .c_in(c_in)); 
    Nbit_NOT #(.N(N)) Not (.outval(not_a_out), .inval(a)); 
    assign sum_select = select ? not_a_out : sum_adder; 
    NbitReg #(.N(N)) Sum_Reg (.outval(sum), .inval(sum_select), .clk(clk));
    NbitReg #(.N(1)) Cout_Reg (.outval(c_out), .inval(c_adder), .clk(clk));
    
endmodule