`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 10:38:53 AM
// Design Name: 
// Module Name: mux32to1
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


module mux32to1(
    output reg out,
    output reg [31:0] sum,
    input [31:0] a,  
    input [31:0] b,  
    input select,
    input cin_1,
    input cin_2
    );
    
    always @(a or b or cin_1 or cin_2 or select)
        begin 
            if (select)
                begin 
                    out = cin_2;
                    sum = b;
                end 
            else 
                begin
                    out = cin_1; 
                    sum = a;
                end 
       end 
endmodule
