`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 08:34:42 AM
// Design Name: 
// Module Name: sixteenbitRCA
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


module sixteenbitRCA(
    output c_out,
    output [15:0] sum,
    input [15:0] a,
    input [15:0] b,
    input c_in
    );
    
    wire f1_cout, f2_cout, f3_cout; 
    
    fourbitRCA F1(.c_out(f1_cout), .sum(sum[3:0]), .a(a[3:0]), .b(b[3:0]), .c_in(c_in)); 
    fourbitRCA F2(.c_out(f2_cout), .sum(sum[7:4]), .a(a[7:4]), .b(b[7:4]), .c_in(f1_cout)); 
    fourbitRCA F3(.c_out(f3_cout), .sum(sum[11:8]), .a(a[11:8]), .b(b[11:8]), .c_in(f2_cout)); 
    fourbitRCA F4(.c_out(c_out), .sum(sum[15:12]), .a(a[15:12]), .b(b[15:12]), .c_in(f3_cout)); 

endmodule
