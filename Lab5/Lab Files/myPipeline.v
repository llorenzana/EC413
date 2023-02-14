`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2022 17:18:37
// Design Name: 
// Module Name: myPipeline
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


module myPipeline(
    input clk,
    input rst,
    input [31:0] InstrIn,
    output [31:0] ALUOut
    );

    wire [4:0] S1_Reg_ReadSelect1;
    wire [4:0] S1_Reg_ReadSelect2;
    wire [15:0] S1_S2_IMM;
    wire S1_S2_DataSource;
    wire [2:0] S1_S2_ALUOP;
    wire [4:0] S1_S2_WriteSelect;
    wire S1_S2_WriteEnable;
    
    wire [31:0] Reg_S2_ReadData1;
    wire [31:0] Reg_S2_ReadData2;
    wire [15:0] S2_Mux_Imm;
    wire S2_Mux_DataSrc;
    wire [2:0] S2_ALU_ALUOp;
    wire [4:0] S2_S3_WriteSelect;
    wire S2_S3_WriteEnable;
    wire [31:0] S2_Mux_ReadData2;
    
    wire [4:0] S3_Reg_WriteSelect;
	wire S3_Reg_WriteEnable;
	
	wire c_out; // dummy wire
	
	wire [31:0] R1, R2, R3;
	
	S1_Reg Stage1(
        .clk(clk),
        .rst(rst),
        .InstrIn(InstrIn),
        .S1_ReadSelect1(S1_Reg_ReadSelect1),
        .S1_ReadSelect2(S1_Reg_ReadSelect2),
        .S1_IMM(S1_S2_IMM),
        .S1_DataSource(S1_S2_DataSource),
        .S1_ALUOP(S1_S2_ALUOP),
        .S1_WriteSelect(S1_S2_WriteSelect),
        .S1_WriteEnable(S1_S2_WriteEnable)
   );
   
   nbit_register_file Register_File (
        .write_data(ALUOut),
        .read_data_1(Reg_S2_ReadData1),
        .read_data_2(Reg_S2_ReadData2),
        .read_sel_1(S1_Reg_ReadSelect1),
        .read_sel_2(S1_Reg_ReadSelect2),
        .write_address(S3_Reg_WriteSelect),
        .RegWrite(S3_Reg_WriteEnable),
        .clk(clk)
    );
    
    S2_Reg Stage2(
        .clk(clk),
        .rst(rst),
        .Reg_ReadData1(Reg_S2_ReadData1),
        .Reg_ReadData2(Reg_S2_ReadData2),
        .S1_Imm(S1_S2_IMM),
        .S1_DataSrc(S1_S2_DataSource),
        .S1_ALUOp(S1_S2_ALUOP),
        .S1_WriteSelect(S1_S2_WriteSelect),
        .S1_WriteEnable(S1_S2_WriteEnable),
        .S2_ReadData1(R2),
        .S2_ReadData2(S2_Mux_ReadData2),
        .S2_Imm(S2_Mux_Imm),
        .S2_DataSrc(S2_Mux_DataSrc),
        .S2_ALUOp(S2_ALU_ALUOp),
        .S2_WriteSelect(S2_S3_WriteSelect),
        .S2_WriteEnable(S2_S3_WriteEnable)
    );
    
    assign R3 = (S2_Mux_DataSrc)? S2_Mux_Imm: S2_Mux_ReadData2;
    
    
    myALU ALU(
        .c_out(c_out),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .c_in(1'b0),
        .AOp(S2_ALU_ALUOp),
        .clk(clk)
    );
    
    /*
    Ideal_ALU ALU(
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .ALUOp(S2_ALU_ALUOp)
    );
    */
    
    S3_Reg Stage3(
        .clk(clk),
        .rst(rst),
        .R1(R1),
        .S2_WriteSelect(S2_S3_WriteSelect),
        .S2_WriteEnable(S2_S3_WriteEnable),
        .ALUOUT(ALUOut),
        .S3_WriteSelect(S3_Reg_WriteSelect),
        .S3_WriteEnable(S3_Reg_WriteEnable)
    );
    
endmodule
