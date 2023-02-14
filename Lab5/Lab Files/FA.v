`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2022 17:55:42
// Design Name: 
// Module Name: FA
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


module FA(cout, sum, a, b, cin);
    input a, b, cin;
    output cout, sum;
    
    wire w1, w2, w3;
    
    // Sum
    xor(w1, a, b);
    xor(sum, w1, cin);
    
    // Cout
    and(w2, a, b);
    and(w3, w1, cin);
    or(cout, w2, w3);
    
endmodule
