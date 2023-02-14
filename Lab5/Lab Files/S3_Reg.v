`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2022 04:07:59 PM
// Design Name: 
// Module Name: S3_Reg
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


module S3_Reg(
    input clk, 
    input rst,
    input [31:0]R1, //ALU input
    input [4:0]S2_WriteSelect,
    input S2_WriteEnable, 
    output reg [31:0] ALUOUT,
    output reg [4:0] S3_WriteSelect,
	output reg S3_WriteEnable
    );
    
    always@(posedge clk)
		begin
		if (rst)
			begin
			ALUOUT <= 32'b0;
			S3_WriteSelect <= 5'd0;
			S3_WriteEnable <= 1'b0;
			end
		else
			begin
			ALUOUT <= R1; 
			S3_WriteSelect <= S2_WriteSelect;
			S3_WriteEnable <= S2_WriteEnable;
			end
		end

endmodule
