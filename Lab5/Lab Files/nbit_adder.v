`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 13:48:15
// Design Name: 
// Module Name: nbit_adder
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


module nbit_adder(c_out, sum, a, b, c_in);
    parameter n = 8;
    input [n-1:0] a;
    input [n-1:0] b;
    input c_in;
    output c_out;
    output [n-1:0] sum;
    
    wire [n:0] carry;
    assign carry[0] = c_in;
    assign c_out = carry[n];
    genvar i;
    
    generate 
        for(i = 0; i < n; i = i + 1) begin // get sum of a + b + c_in
            FA oneBit_FA (carry[i+1], sum[i], a[i], b[i], carry[i]);
        end
    endgenerate
endmodule
