`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 12:39:47 PM
// Design Name: 
// Module Name: OR_D
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

`define	D		1	// definition of the delay

// Delayed OR gate

module OR_D(out, in1, in2);

input in1, in2;
output out;

or		#`D		or1 (out, in1, in2);


endmodule