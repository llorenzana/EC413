`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 07:15:16 PM
// Design Name: 
// Module Name: Verification_RegAdder
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


module Verification_RegAdder #(parameter N = 32) (
    output reg c_out,
    output reg [N-1:0] sum, 
    input  [N-1 :0] a,
    input  [N-1 :0] b,
    input  c_in, 
    input select,
    input  clk
    );
    
    wire [N-1:0] sum_temp;
    wire c_out_temp; 
    assign {c_out_temp, sum_temp} = a + b + c_in; 
    
    always @(posedge clk) begin
        c_out <= c_out_temp;
        sum <= (select) ? ~a : sum_temp;
    end 
   
endmodule
