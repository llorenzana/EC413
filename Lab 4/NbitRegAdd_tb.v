`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 07:04:18 PM
// Design Name: 
// Module Name: NbitRegAdd_tb
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


module NbitRegAdd_tb(
    );

    parameter N = 32; 
    
    //Input 
    reg  [N-1 :0] a;
    reg  [N-1 :0] b;
    reg  c_in;
    reg select;
    reg  clk;

    //output 
    wire c_out;
    wire [N-1:0] sum;
    wire c_out_verify; 
    wire [N-1:0] sum_verify; 
    wire error_flag; 
    
    //Instatiation 
    NbitRegAdd #(.N(N)) RegAdder(
        .c_out(c_out),
        .sum(sum), 
        .a(a),
        .b(b),
        .c_in(c_in), 
        .select(select),
        .clk(clk)
    );
    
    Verification_RegAdder #(.N(N)) Verify(
        .c_out(c_out_verify),
        .sum(sum_verify), 
        .a(a),
        .b(b),
        .c_in(c_in), 
        .select(select),
        .clk(clk)
   );
   
   assign error_flag = (c_out != c_out_verify || sum != sum_verify); 
   
   //Verification logic 
   always @(posedge clk)
        begin 
        if(error_flag == 1'b1)
          //Use $display here instead of $monitor 
          //$monitor will siplay the message whenever there's a change of a, b, c_in 
          // $display will only display once when it's been executed 
          $display("Error occurs when a = %d, b = %d, c_in = %d, slect = %d \n", a, b, c_in, select); 
        end 
   
   //wave form test 
   initial begin 
       c_in = 0; 
       a = 0; 
       a = 3'd7;
       b = 0; 
       clk = 0;
       select = 0;
   end 
   
   //generate clock cycles
   always #5 clk = ~clk; 
   
   always @(posedge clk) begin 
        {c_in, a, b, select} <= {c_in, a, b, select} + 1'b1;
   end 
   
endmodule
