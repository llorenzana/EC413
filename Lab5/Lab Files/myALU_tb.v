`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.10.2022 20:20:22
// Design Name: 
// Module Name: myALU_tb
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


module myALU_tb(
    );
    parameter n = 32;
    reg [n-1:0] R2;
    reg [n-1:0] R3;
    reg c_in;
    reg clk;
    wire c_out;
    //wire [n-1:0] R0;
    wire [n-1:0] R1;
    reg [2:0] AOp;
    //wire c_out_verify;
    wire [n-1:0] R0_verify;
    wire error_flag;
    
    
    myALU #(.n(n)) ALU(
        .c_out(c_out),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .c_in(c_in),
        .AOp(AOp),
        .clk(clk)
    );
    
    /*
    Ideal_ALU #(.n(n)) ALU(
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .ALUOp(AOp)
    );
    */
    
    /* Created own verification module to test
    verification_myALU #(.n(n)) ALUverify(
        .c_out(c_out_verify),
        .R0(R0_verify),
        .R2(R2),
        .R3(R3),
        .c_in(c_in),
        .AOp(AOp),
        .clk(clk)
    );
    */
    
    //ALU_behavioral is delayed by one clock cycle due to not outputting to register
    ALU_behavioral #(.n(n)) ALUverify(
        .R2(R2),
        .R3(R3),
        .ALUOp(AOp),
        .c_in(c_in),
        .R1(R0_verify)
    );
    
    
    //assign error_flag = (c_out != c_out_verify || R0 != R0_verify);
    assign error_flag = R1 != R0_verify;
    always @(posedge clk) begin
        if(error_flag == 1'b1)
            $display("Error occurs when R2 = %d, R3 = %d, c_in = %d, AOp = %d\n", R2, R3, c_in, AOp);
    end
    
    initial begin
        R2 = 0;
        R3 = 0;
        c_in = 0;
        AOp = 0;
        clk = 0;
    end    
    
    always #5 clk = ~clk;
    
    initial begin
        #40 //---------------------------------------MOV
        R2 = 32'b01101100111000010101000010110101;
        
        #40 //---------------------------------------NOT
        AOp = 3'b001;
        
        #40 //---------------------------------------ADD
        AOp = 3'b010;
        R2 = 32'b00000000000000000000000000000100;
        R2 = 32'b00000000000000000000000000000100;
        
        #40
        R2 = 32'b00000000000000000000000000000100;
        R2 = 32'b00000000000000000000000000000100;
        //c_in = 1'b1;
        
        #40
        R2 = 32'b10001100111000010101000010110101;
        R3 = 32'b01010100110010111000000100011001;
        //c_in = 1'b0;
        
        #40
        R2 = 32'b11111111111111111111111111111111;
        R3 = 32'b11111111111111111111111111111111;
        
        #40
        R2 = 32'b00000000000000000000000000000000;
        R3 = 32'b11111111111111111111111111111111;
        //c_in = 1'b1;
        
        #40
        R2 = 32'b00000000000000000000000000000001;
        R3 = 32'b11111111111111111111111111111111;
        //c_in = 1'b0;
        
        #40 //---------------------------------------SUB
        AOp = 3'b011;
        R2 = 32'b00000000000000000000000000000101;
        R3 = 32'b00000000000000000000000000000010;
        
        #40
        R2 = 32'b00000000000000000000000000000010;
        R3 = 32'b00000000000000000000000000000101;
        
        #40
        R2 = 32'b00000000000000000000000000000101;
        R3 = 32'b00000000000000000000000000000101;
        
        #40
        R2 = 32'b00000000000000000000000000000000;
        R3 = 32'b00000000000000000000000000000101;
        
        #40
        R2 = 32'b11111111111111111111111111111011;
        R3 = 32'b00000000000000000000000000000010;
        
        #40
        R2 = 32'b10001100111000010101000010110101;
        R3 = 32'b01010100110010111000000100011001;
        
        #40 //---------------------------------------OR
        AOp = 3'b100;
        R2 = 32'b11011100110010110100010111101110;
        R3 = 32'b00001100111000010101000010110101;
        
        #40
        R2 = 32'b00000000000000000000000000000001;
        R3 = 32'b11111111111111111111111111111111;
        
        #40
        R2 = 32'b10101010101010101010101010101010;
        R3 = 32'b11111111111111111111111111111111;
        
        #40 //---------------------------------------AND
        AOp = 3'b101;
        R2 = 32'b11011100110010110100010111101110;
        R3 = 32'b00001100111000010101000010110101;
        
        #40
        R2 = 32'b10101010101010101010101010101010;
        R3 = 32'b11111111111111111111111111111111;
        
        #40
        R2 = 32'b00000000000000000000000000000000;
        R3 = 32'b11111111111111111111111111111111;
        
        #40 //---------------------------------------SLT
        AOp = 3'b110;
        R2 = 32'b11011100110010110100010111101110;
        R3 = 32'b00001100111000010101000010110101;
        
        #40
        R2 = 32'b10101010101010101010101010101010;
        R3 = 32'b11111111111111111111111111111111;
        
        #40
        R2 = 32'b00000000000000000000000000000000;
        R3 = 32'b11111111111111111111111111111111;
        
    end
    
endmodule