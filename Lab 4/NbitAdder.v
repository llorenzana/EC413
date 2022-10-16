`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 01:20:19 PM
// Design Name: 
// Module Name: NbitAdder
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


module NbitAdder#(parameter N = 32)(
    output c_out,
    output [N-1:0] sum, 
    input  [N-1 :0] a,
    input  [N-1 :0] b,
    input  c_in
    );
    
    wire [N:0] carry; 
    assign carry[0] = c_in; 
    assign c_out = carry[N];
    
    genvar i; //loop
    
    generate
        for (i = 0; i < N; i = i + 1) begin
            FA_str FA1 (.c_out(carry[i+1]), .sum(sum[i]), .a(a[i]), .b(b[i]), .c_in(carry[i]));  
        end 
    endgenerate 
      
endmodule
