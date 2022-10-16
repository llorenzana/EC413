`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 11:07:13 AM
// Design Name: 
// Module Name: CSA
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


module CSA(
    output c_out,
    output [63:0] sum,
    input [63:0] a,
    input [63:0] b,
    input c_in
    );
    
    wire select_out, r2_cout, r3_cout; 
    wire [31:0] r2_sum, r3_sum;
    
    thirtytwobitRCA r1(.c_out(select_out), .sum(sum[31:0]), .a(a[31:0]), .b(b[31:0]), .c_in(c_in)); 
    
    thirtytwobitRCA r2(.c_out(r2_cout), .sum(r2_sum[31:0]), .a(a[63:32]), .b(b[63:32]), .c_in(0)); 
    thirtytwobitRCA r3(.c_out(r3_cout), .sum(r3_sum[31:0]), .a(a[63:32]), .b(b[63:32]), .c_in(1)); 
    
    mux32to1 mux(.out(c_out), .sum(sum[63:32]), .a(r2_sum[31:0]), .b(r3_sum[31:0]), .select(select_out), .cin_1(r2_cout), .cin_2(r3_cout)); 

endmodule
