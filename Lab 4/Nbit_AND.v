`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 08:11:34 PM
// Design Name: 
// Module Name: Nbit_AND
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


module Nbit_AND #(parameter N = 32)(
    output [N-1:0] outval, 
    input  [N-1:0] inval1,
    input  [N-1:0] inval2
    );
    
    genvar i; 
    
    generate 
        for (i = 0; i < N; i = i + 1) begin
            and and_gate(outval[i], inval1[i], inval2[i]);
        end
   endgenerate 
   
endmodule
