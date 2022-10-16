`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 10:25:45 AM
// Design Name: 
// Module Name: thirtytwobitRCA
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


module thirtytwobitRCA(
    output c_out,
    output [31:0] sum,
    input [31:0] a,
    input [31:0] b,
    input c_in
    );
    
     wire f1_cout; 
    
    sixteenbitRCA F1(.c_out(f1_cout), .sum(sum[15:0]), .a(a[15:0]), .b(b[15:0]), .c_in(c_in)); 
    sixteenbitRCA F2(.c_out(c_out), .sum(sum[31:16]), .a(a[31:16]), .b(b[31:16]), .c_in(f1_cout)); 
    
endmodule
