`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 16:29:07
// Design Name: 
// Module Name: myALU
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


module myALU(c_out, R1, R2, R3, c_in, AOp, clk);
    
    // I/O Declaration
    parameter n = 32;
    input [n-1:0] R2;
    input [n-1:0] R3;
    input clk;
    input c_in;
    output reg [n-1:0] R1;
    output c_out;
    input [2:0] AOp;
    
    // Variable Declaration
    
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
    wire slt_out;
    
    /*
    always @(*)begin
        case(AOp)
            3'b000: R1 = R2;
            3'b001: R1 = ~R2;
            3'b010: R1 = (R2 + R3);
            3'b011: R1 = (R2 - R3);
            3'b100: R1 = (R2 | R3);
            3'b101: R1 = (R2 & R3);
            3'b110: R1 = (($signed(R2) < $signed(R3))? 1:0);
            default: R1 = 0;
        endcase
    end
    */
    
    // Assigning each input of ALU
    assign reg_out = R2;
    nbit_not #(n) nnot (not_out, R2);
    nbit_adder #(n) adder (c_adder, add_out, R2, R3, c_in);
    nbit_sub #(n) sub (c_sub, sub_out, R2, R3, c_in);
    nbit_or #(n) orr (or_out, R2, R3);
    nbit_and #(n) andd (and_out, R2, R3);
    nbit_slt #(n) slt (slt_out, R2, R3);

    
    // MUX
    always @(*) begin
        case(AOp)
            3'b000: begin // MOV
                R1 <= reg_out; 
                c_select <= 0;
            end
            3'b001: begin // NOT
                R1 <= not_out;
                c_select <= 0;
            end
            3'b010: begin // ADD
                R1 <= add_out; 
                c_select <= c_adder;
            end
            3'b011: begin // SUB
                R1 <= sub_out;
                c_select <= c_sub;
            end
            3'b100: begin // OR
                R1 <= or_out;
                c_select <= 0;
            end
            3'b101: begin // AND
                R1 <= and_out;
                c_select <= 0;
            end
            3'b110: begin
                R1 <= slt_out;
                //R1 = (($signed(R2) < $signed(R3))? 1:0);
                c_select <= 0;
            end
            default: begin
                R1 <= 0;
                c_select <= 0;
            end
        endcase
    end
    
    // Put output to wire
    assign c_out = c_select;
    assign R0 = R1;

    
    /*
    // Pass output to register and receive register output
    nbit_reg #(n) sum_reg(R0, R1_wire, clk);
    nbit_reg #(1) cout_reg(c_out, c_select_wire, clk);
    */
endmodule
