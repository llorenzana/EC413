`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 01:34:00 PM
// Design Name: 
// Module Name: NbitReg_tb
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


module NbitReg_tb(

    );
    
    parameter N = 32; 
    reg [N-1:0] d; 
    reg clk; 
    
    wire [N-1:0] q; 
    
    NbitReg #(.N(N)) registerTest(
    .outval(q), 
    .inval(d), 
    .clk(clk)
    ); 
    
    initial begin 
        d = 0; 
        clk = 0; 
        
        #100; 
        
    end 
    
    always    
        #5 clk = ~clk; 
        
        always 
        #20 d = d+1; 
endmodule
