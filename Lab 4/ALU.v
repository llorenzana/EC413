`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2022 10:10:45 AM
// Design Name: 
// Module Name: ALU
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


module ALU#(parameter N = 32) (
    output c_out,
    output [N-1:0] R0,
    output [N-1:0] R1,
    input [N-1:0] R2,
    input [N-1:0] R3,
    input [2:0] ALUOp,
    input c_in,
    input clk 
    );
    
     wire [N-1:0] result;
     wire c_out_result; 
    
    wire [N-1:0] MOV; 
    wire [N-1:0] NOT; 
    wire [N-1:0] ADD; 
    wire [N-1:0] SUB; 
    wire [N-1:0] OR; 
    wire [N-1:0] AND;
    wire [N-1:0] SLT; //ALUOp = 3'110
    wire c_out_ADD;  //carry out to be used in mux
    wire c_out_SUB;  // carry out to be used in mux
    
   
    
    //MUX for ALUOp 
    mux #(.N(N)) mALUOps (.outval(result[N-1:0]), .ALUOp(ALUOp[2:0]), .MOV(MOV[N-1:0]),.NOT(NOT[N-1:0]), .ADD(ADD[N-1:0]), .SUB(SUB[N-1:0]),.OR(OR[N-1:0]), .AND(AND[N-1:0]), .SLT(SLT[N-1:0])); 
    
    //mux for c_out use the given mux to avoid creating more than one MUX and less module ALU_behavioral
    mux #(.N(1)) mC_Out (.outval(c_out_result), .ALUOp(ALUOp[2:0]), .MOV(0),.NOT(0), .ADD(c_out_ADD), .SUB(c_out_SUB), .OR(0), .AND(0), .SLT(0)); 
    
    //MOV ALUOp = 3'b000
    assign MOV[N-1:0] = R2[N-1:0];
    
    //NOT ALUOp = 3'b001
    Nbit_NOT #(.N(N)) notA (.outval(NOT[N-1:0]), .inval(R2[N-1:0]));
    
    //ADD ALUOp = 3'b010
    NbitAdder #(.N(N)) addAB (.c_out(c_out_ADD), .sum(ADD[N-1:0]), .a(R2[N-1:0]), .b(R3[N-1:0]), .c_in(c_in)); 
    
    //SUB ALUOp = 3'b011
    NbitSub #(.N(N)) subAB (.c_out(c_out_SUB), .sum(SUB[N-1:0]), .a(R2[N-1:0]), .b(R3[N-1:0]), .c_in(c_in)); 
    
    //OR ALUOp = 3'b100 
    Nbit_OR #(.N(N)) orAB (.outval(OR[N-1:0]), .inval1(R2[N-1:0]), .inval2(R3[N-1:0])); 
    
    //AND ALUOp = 3'b101
    Nbit_AND #(.N(N)) andAB (.outval(AND[N-1:0]), .inval1(R2[N-1:0]), .inval2(R3[N-1:0])); 
    
   
    // Place values in registers 
    NbitReg #(.N(N)) regChange (.outval(R1), .inval(result[N-1:0]), .clk(clk)); 
    
    //c_out dff 
    dff c_outdff (.q(c_out),.d(c_out_result),.clk(clk)); 
    
endmodule
