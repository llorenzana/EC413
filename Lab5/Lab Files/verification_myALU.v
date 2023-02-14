`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 19:55:31
// Design Name: 
// Module Name: verification_myALU
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


module verification_myALU(c_out, R0, R2, R3, c_in, AOp, clk);
    
    parameter n = 8;
    input [n-1:0] R2;
    input [n-1:0] R3;
    input c_in;
    input clk;
    output c_out;
    output [n-1:0] R0;
    input [2:0] AOp;
    
    wire c_adder;
    wire c_sub;
    reg c_select;
    wire c_select_wire;
    reg [n-1:0] R1;
    wire [n-1:0] R1_wire;
    wire [n-1:0] reg_out;
    wire [n-1:0] not_out;
    wire [n-1:0] add_out;
    wire [n-1:0] sub_out;
    wire [n-1:0] or_out;
    wire [n-1:0] and_out;
    //wire [n-1:0] slt_out
    
    assign reg_out = R2;
    assign not_out = ~R2;
    assign {c_adder, add_out} = R2 + R3 + c_in;
    assign {c_sub, sub_out} = R2 - R3;
    assign or_out = R2|R3;
    assign and_out = R2&R3;
    //assign slt_out = 
    
    always @(R2 or R3 or c_in or AOp or posedge clk) begin
        case(AOp)
            3'b000: begin 
                R1 <= reg_out; //assign R1 = reg_out;
                c_select <= 0;
            end
            3'b001: begin
                R1 <= not_out; //assign R1 = not_out;
                c_select <= 0;
            end
            3'b010: begin 
                R1 <= add_out; //assign R1 = add_out; 
                c_select <= c_adder; //assign c_select = c_adder;
            end
            3'b011: begin
                R1 <= sub_out; //assign R1 = sub_out;
                c_select <= ~c_sub; //assign c_select = c_sub;
            end
            3'b100: begin
                R1 <= or_out; //assign R1 = or_out;
                c_select <= 0;
            end
            3'b101: begin
                R1 <= and_out; //assign R1 = and_out;
                c_select <= 0;
            end
            //3'b110: assign R1 = 
            default: begin
                R1 <= 0; //assign R1 = 0;
                c_select <= 0;
            end
        endcase
    end
    
    assign c_select_wire = c_select;
    assign R1_wire = R1;
    
    //assign c_out = c_select;
    //assign R0 = R1;
    
    nbit_reg #(n) sum_reg(R0, R1_wire, clk);
    nbit_reg #(1) cout_reg(c_out, c_select_wire, clk);
    
endmodule
