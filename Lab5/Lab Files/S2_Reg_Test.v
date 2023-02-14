`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2022 19:44:54
// Design Name: 
// Module Name: S2_Reg_Test
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


module S2_Reg_Test(
    );
    
    reg clk;
    reg rst;
    reg [31:0] Reg_ReadData1;
    reg [31:0] Reg_ReadData2;
    reg [15:0] S1_Imm;
    reg S1_DataSrc;
    reg [2:0] S1_ALUOp;
    reg [4:0] S1_WriteSelect;
    reg S1_WriteEnable;
    wire [31:0] S2_ReadData1;
    wire [31:0] S2_ReadData2;
    wire [15:0] S2_Imm;
    wire S2_DataSrc;
    wire [2:0] S2_ALUOp;
    wire [4:0] S2_WriteSelect;
    wire S2_WriteEnable;
    
    S2_Reg Stage2(
        .clk(clk),
        .rst(rst),
        .Reg_ReadData1(Reg_ReadData1),
        .Reg_ReadData2(Reg_ReadData2),
        .S1_Imm(S1_Imm),
        .S1_DataSrc(S1_DataSrc),
        .S1_ALUOp(S1_ALUOp),
        .S1_WriteSelect(S1_WriteSelect),
        .S1_WriteEnable(S1_WriteEnable),
        .S2_ReadData1(S2_ReadData1),
        .S2_ReadData2(S2_ReadData2),
        .S2_Imm(S2_Imm),
        .S2_DataSrc(S2_DataSrc),
        .S2_ALUOp(S2_ALUOp),
        .S2_WriteSelect(S2_WriteSelect),
        .S2_WriteEnable(S2_WriteEnable)
    );
    
    always #5 assign clk = ~clk;
   
   initial begin
		rst = 1;
		clk = 0;
        Reg_ReadData1 = 32'b00000000000000000000000000000000;
        Reg_ReadData2 = 32'b00000000000000000000000000000000;
        S1_Imm = 16'b0000000000000000;
        S1_DataSrc = 1'b0;
        S1_ALUOp = 3'b000;
        S1_WriteSelect = 5'b00000;
        S1_WriteEnable = 5'b00000;
        
        
        #10
        rst = 0;
        
        #30
		Reg_ReadData1 = 32'b11110010010101111111110011010100;
        Reg_ReadData2 = 32'b10110110110111010111001111110011;
        S1_Imm = 16'b0000000000000101;
        S1_DataSrc = 1'b1;
        S1_ALUOp = 3'b010;
        S1_WriteSelect = 5'b00000;
        S1_WriteEnable = 5'b00000;
		
		#10
		Reg_ReadData1 = 32'b00000110111001001101000110011101;
        Reg_ReadData2 = 32'b11010010001001100110101100110011;
        S1_Imm = 16'b1101100100100001;
        S1_DataSrc = 1'b0;
        S1_ALUOp = 3'b101;
        S1_WriteSelect = 5'b11111;
        S1_WriteEnable = 5'b10101;
   end
    
endmodule
