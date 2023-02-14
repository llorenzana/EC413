`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2022 18:04:13
// Design Name: 
// Module Name: nbit_slt
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


module nbit_slt(out, a, b);
    parameter n = 8;
    input [n-1:0] a;
    input [n-1:0] b;
    output reg out;
    
    wire [n-1:0] diff;
    wire cout; // dummy wire
    
    //nbit_sub sub (cout, diff, a, b, 1'b1);
    assign diff = a - b;
    
    always @(*) begin
        if(a == b) //--------------------------if equal
            out <= 1'b0;
        else if(a[n-1] == 1 && b[n-1] == 0) //-if a is negative and b is positive
            out <= 1'b1;
        else if(a[n-1] == 0 && b[n-1] == 1) //-if a is positive and b is negative
            out <= 1'b0;
        else //--------------------------------if both same sign
            out <= diff[n-1]; // get difference from msb
    end
    
endmodule
