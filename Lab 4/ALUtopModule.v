`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 10:55:18 PM
// Design Name: 
// Module Name: ALUtopModule
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


module ALUtopModule #(parameter N = 32) (
    output c_out,
    output [N-1:0] R0,
    output reg [N-1:0] R1,
    input [N-1:0] R2,
    input [N-1:0] R3,
    input [2:0] ALUOp,
    input c_in,
    input clk 
    );
    
    reg c_out_result; 
    wire [N-1:0] MOV; 
    wire [N-1:0] NOT; 
    wire [N-1:0] ADD; 
    wire [N-1:0] SUB; 
    wire [N-1:0] OR; 
    wire [N-1:0] AND;
    wire [N-1:0] SLT; //ALUOp = 3'110
    wire c_out_ADD;  //carry out to be used in mux
    wire c_out_SUB;  // carry out to be used in mux
    
   
    
    //MOV ALUOp = 3'b000
    assign MOV[N-1:0] = R2[N-1:0];
    
    //NOT ALUOp = 3'b001
    Nbit_NOT #(.N(N)) notA (.outval(NOT[N-1:0]), .inval(R2[N-1:0]));
    
    //ADD ALUOp = 3'b010
    NbitAdder #(.N(N)) addAB (.c_out(c_out_ADD), .sum(ADD[N-1:0]), .a(R2[N-1:0]), .b(R3[N-1:0]), .c_in(c_in)); 
    
    //SUB ALUOp = 3'b011
    NbitSub #(.N(N)) subAB (.c_out(c_out_SUB), .sum(SUB[N-1:0]), .a(R2[N-1:0]), .b(R3[N-1:0]), .c_in(1)); 
    
    //OR ALUOp = 3'b100 
    Nbit_OR #(.N(N)) orAB (.outval(OR[N-1:0]), .inval1(R2[N-1:0]), .inval2(R3[N-1:0])); 
    
    //AND ALUOp = 3'b101
    Nbit_AND #(.N(N)) andAB (.outval(AND[N-1:0]), .inval1(R2[N-1:0]), .inval2(R3[N-1:0])); 
       
   
    //MUX for ALUOp 
    always @(*) begin
        case(ALUOp)
            3'b000:  
                R1[N-1:0] = MOV[N-1:0]; 
            3'b001:  
                R1[N-1:0] = NOT[N-1:0]; 
            3'b010:  
                begin
                    R1[N-1:0] = ADD[N-1:0];
                    c_out_result = c_out_ADD;
                end  
            3'b011:  
                begin
                    R1[N-1:0] = SUB[N-1:0]; 
                    c_out_result = c_out_SUB; 
                end
            3'b100:  
                R1[N-1:0] = OR[N-1:0]; 
            3'b101:  
                R1[N-1:0] = AND[N-1:0]; 
            3'b110:  
                R1[N-1:0] = SLT[N-1:0]; 
        endcase 
   end 
       
   
    // Place values in registers 
    NbitReg #(.N(N)) regChange (.outval(R0[N-1:0]), .inval(R1[N-1:0]), .clk(clk)); 
    
    //dff for c_out
    dff dffcoutcheck(.q(c_out), .d(c_out_result), .clk(clk));
   
endmodule
