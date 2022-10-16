`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 01:49:09 PM
// Design Name: 
// Module Name: Nbit_NOT
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


module Nbit_NOT#(parameter N = 32)(
    output [N-1:0] outval, 
    input  [N-1:0] inval
    );
    
    genvar i; //loop variable
    
    generate
        for (i = 0; i < N; i = i + 1) begin
            not(outval[i],inval[i]);
        end
   endgenerate
   
endmodule
