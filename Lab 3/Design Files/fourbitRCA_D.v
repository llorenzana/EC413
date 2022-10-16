`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 12:46:28 PM
// Design Name: 
// Module Name: fourbitRCA_D
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


module fourbitRCA_D(
    output c_out,
    output [3:0] sum,
    input [3:0] a,
    input [3:0] b,
    input c_in
    );
    
    wire f1_cout, f2_cout, f3_cout; 
    
    FA_str_D F1(.c_out(f1_cout), .sum(sum[0]), .a(a[0]), .b(b[0]), .c_in(c_in)); 
    FA_str_D F2(.c_out(f2_cout), .sum(sum[1]), .a(a[1]), .b(b[1]), .c_in(f1_cout)); 
    FA_str_D F3(.c_out(f3_cout), .sum(sum[2]), .a(a[2]), .b(b[2]), .c_in(f2_cout)); 
    FA_str_D F4(.c_out(c_out), .sum(sum[3]), .a(a[3]), .b(b[3]), .c_in(f3_cout)); 

endmodule
