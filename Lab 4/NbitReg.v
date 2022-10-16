`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 12:39:19 PM
// Design Name: 
// Module Name: NbitReg
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


module NbitReg(
    output [N-1:0] outval, 
    input  [N-1:0] inval,
    input  clk
    );
    
    parameter N = 32; 
    
    genvar i; //loop
    
    generate
        for (i = 0; i < N; i = i + 1)
            begin: registerblk
                dff DF1 (.q(outval[i]), .d(inval[i]), .clk(clk));  
        end   

    endgenerate 
    
endmodule
