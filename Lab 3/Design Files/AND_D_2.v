`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 02:03:34 PM
// Design Name: 
// Module Name: AND_D_2
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

// Delayed AND gate

module AND_D_2(out, in1, in2);

input in1, in2;
output out;

and		#`D		and1(out, in1, in2);


endmodule