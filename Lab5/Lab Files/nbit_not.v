`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 13:48:37
// Design Name: 
// Module Name: nbit_not
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


module nbit_not(out,in);
    parameter n = 8;
    input [n-1:0] in;
    output [n-1:0] out;
    genvar i;
    
    generate
        for(i = 0; i < n; i = i + 1) begin
            not(out[i],in[i]); //Store complement of each bit in out
        end
    endgenerate
    
endmodule
