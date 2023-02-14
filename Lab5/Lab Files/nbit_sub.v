`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 15:59:12
// Design Name: 
// Module Name: nbit_sub
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


module nbit_sub(c_out, sum, a, b, c_in);
    
    parameter n = 8;
    input [n-1:0] a;
    input [n-1:0] b;
    input c_in; //ignore
    output c_out;
    output [n-1:0] sum;
    
    wire [n:0] carry;
    wire [n-1:0] b_not;
    assign carry[0] = 1; //Assign one for c_in
    assign c_out = carry[n];
    nbit_not #(.n(n)) myNot(.out(b_not),.in(b)); //get complement of B
    genvar i;
    
    generate 
        for(i = 0; i < n; i = i + 1) begin //get sum of a and bnot and carry in
            FA oneBit_FA (carry[i+1], sum[i], a[i], b_not[i], carry[i]);
        end
    endgenerate
    
endmodule
