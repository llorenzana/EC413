`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2022 17:15:25
// Design Name: 
// Module Name: Verification_16bit
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


module Verification_16bit(
    output c_out,
    output [15:0] sum,
    input [15:0] a,
    input [15:0] b,
    input c_in
    );
    
	assign {c_out, sum} = a + b + c_in;
endmodule
