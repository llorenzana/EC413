`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 15:59:12
// Design Name: 
// Module Name: nbit_and
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


module nbit_and(out,a,b);
    parameter n = 8;
    input [n-1:0] a;
    input [n-1:0] b;
    output [n-1:0] out;
    genvar i;
    
    generate
        for(i = 0; i < n; i = i + 1) begin
            and(out[i],a[i],b[i]); // store a & b and store in out
        end
    endgenerate
endmodule
