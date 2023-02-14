`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2022 19:33:12
// Design Name: 
// Module Name: S1_Reg_Test
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


module S1_Reg_Test(
    );
    reg [31:0]InstrIn;
    reg clk;
    reg rst;
    wire [4:0]S1_ReadSelect1;
    wire [4:0]S1_ReadSelect2;
    wire [15:0]S1_IMM;
    wire S1_DataSource;
    wire [2:0]S1_ALUOP;
    wire [4:0]S1_WriteSelect;
    wire S1_WriteEnable;
    
    S1_Reg Stage1(
        .clk(clk),
        .rst(rst),
        .InstrIn(InstrIn),
        .S1_ReadSelect1(S1_ReadSelect1),
        .S1_ReadSelect2(S1_ReadSelect2),
        .S1_IMM(S1_IMM),
        .S1_DataSource(S1_DataSource),
        .S1_ALUOP(S1_ALUOP),
        .S1_WriteSelect(S1_WriteSelect),
        .S1_WriteEnable(S1_WriteEnable)
   );
   
   always #5 assign clk = ~clk;
   
   initial begin
        InstrIn = 0;
		rst = 1;
		clk = 0;
        
        #10
        rst = 0;
        
        #30
		InstrIn= 32'b011010_00000_00000_0000000000000101;		// I, add r0 with 00000005 =>   r0 = clk
		
		#10
		InstrIn= 32'b010010_01001_00001_00011_00000000000;		// R, add r1(0000000A) with r3(FFFFFFFF) =>  r9 = 00000009
   end
    
    
    
    
endmodule
