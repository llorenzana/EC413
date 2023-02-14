`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2022 20:04:31
// Design Name: 
// Module Name: S3_Reg_Test
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


module S3_Reg_Test(
    );
    reg clk;
    reg rst;
    reg [31:0]R1; //ALU input
    reg [4:0]S2_WriteSelect;
    reg S2_WriteEnable; 
    wire [31:0] ALUOUT;
    wire [4:0] S3_WriteSelect;
	wire S3_WriteEnable;
	
	S3_Reg Stage3(
        .clk(clk),
        .rst(rst),
        .R1(R1),
        .S2_WriteSelect(S2_WriteSelect),
        .S2_WriteEnable(S2_WriteEnable),
        .ALUOUT(ALUOUT),
        .S3_WriteSelect(S3_WriteSelect),
        .S3_WriteEnable(S3_WriteEnable)
    );
    
    always #5 assign clk = ~clk;
   
    initial begin
		rst = 1;
		clk = 0;
        R1 = 32'b00000000000000000000000000000000;
        S2_WriteSelect = 4'b0000;
        S2_WriteEnable = 1'b0;
        
        #10
        rst = 0;
        
        #30
		R1 = 32'b00000011110110111000010000110010;
        S2_WriteSelect = 4'b1111;
        S2_WriteEnable = 1'b1;
		
		#10
		R1 = 32'b00000011110110111000010000110010;
        S2_WriteSelect = 4'b0101;
        S2_WriteEnable = 1'b0;
	end
endmodule
