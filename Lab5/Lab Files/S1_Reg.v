`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2022 03:49:29 PM
// Design Name: 
// Module Name: S1_Reg
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


module S1_Reg(
    input [31:0]InstrIn,
    input clk,
    input rst,
    output reg [4:0]S1_ReadSelect1,
    output reg [4:0]S1_ReadSelect2,
    output reg [15:0]S1_IMM,
    output reg S1_DataSource,
    output reg [2:0]S1_ALUOP,
    output reg [4:0]S1_WriteSelect,
    output reg S1_WriteEnable
    );
    
    
	always@(posedge clk)
		begin
		if (rst)
			begin
			S1_ReadSelect1 <= 5'd0;
			S1_ReadSelect2 <= 5'd0;
			S1_WriteSelect <= 5'd0;
			S1_WriteEnable <= 1'b0;
			S1_IMM <= 16'b0;
			S1_DataSource <= 1'b0;
			S1_ALUOP <= 3'b0; 
			end
		
		else
			begin
			S1_ReadSelect1 <= InstrIn[20:16];
			S1_ReadSelect2 <= InstrIn[15:11];
			S1_WriteSelect <= InstrIn[25:21];
			S1_WriteEnable <= 1'b1;
			S1_IMM <= InstrIn[15:0]; //the immediate
			S1_DataSource <= InstrIn[29]; //Is it I or R type?
			S1_ALUOP <= InstrIn[28:26]; //ALU operation
			end
		end
endmodule
