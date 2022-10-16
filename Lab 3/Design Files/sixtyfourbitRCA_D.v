`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 12:51:55 PM
// Design Name: 
// Module Name: sixtyfourbitRCA_D
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


module sixtyfourbitRCA_D(
    output c_out,
    output [63:0] sum,
    input [63:0] a,
    input [63:0] b,
    input c_in
    );
    
    wire f1_cout; 
    
    thirtytwobitRCA_D F1(.c_out(f1_cout), .sum(sum[31:0]), .a(a[31:0]), .b(b[31:0]), .c_in(c_in)); 
    thirtytwobitRCA_D F2(.c_out(c_out), .sum(sum[63:32]), .a(a[63:32]), .b(b[63:32]), .c_in(f1_cout)); 
    
endmodule
