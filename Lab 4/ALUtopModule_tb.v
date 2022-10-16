`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 11:45:42 PM
// Design Name: 
// Module Name: ALUtopModule_tb
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


module ALUtopModule_tb(

    );
    parameter N = 32;
    
    // inputs 
    reg [N-1:0] R2;
    reg [N-1:0] R3;
    reg [2:0] ALUOp;
    reg c_in;
    reg clk; 
    
    //outputs 
    //wire c_out;
    wire c_out; 
    wire [N-1:0] R0;
    wire [N-1:0] R1; 
    wire [N-1:0] verifyALU; 
    
    ALUtopModule #(.N(N)) ALUtest(
        .c_out(c_out),
        .R0(R0[N-1:0]),
        .R1(R1[N-1:0]),
        .R2(R2[N-1:0]),
        .R3(R3[N-1:0]),
        .ALUOp(ALUOp[2:0]),
        .c_in(c_in),
        .clk(clk)
    ); 
    
    //Verify ALU 
    ALU_behavioral #(.WIDTH(N)) ALU_verify ( 
        .R2(R2[N-1:0]),
        .R3(R3[N-1:0]),
        .ALUOp(ALUOp[2:0]),
        .R1(verifyALU[N-1:0])
    ); 
    
    assign error_flag = (R1 != verifyALU); 
   
   //Verification logic 
   always @(posedge clk)
        begin 
        if(error_flag == 1'b1)
          //Use $display here instead of $monitor 
          //$monitor will siplay the message whenever there's a change of a, b, c_in 
          // $display will only display once when it's been executed 
          $display("Error occurs when a = %d, b = %d, c_in = %d , ALUOp = %d \n", R2, R3, c_in, ALUOp); 
        end 
    
    //generate clock cycles
   always #5 clk = ~clk; 
   
   initial begin 
        clk = 0; 
        R2 = 0; 
        R3 = 0; 
        c_in = 0; 
        
        #50; //MOV random input
        ALUOp = 3'b000; 
        R2 = 32'h5CC076B2 ; // decimal 1556117170 binary = 01011100110000000111011010110010
        //output: 
        
        #50; //NOT random input
        ALUOp = 3'b001; 
        R2 = 32'h579A9E9B ; // decimal = 1469750939 binary = 01010111100110101001111010011011
        //output: binary 101000011001010110000101100100
        //decimal:  677732708
        //HEX:28656164 
        
        #50; //ADD negative and positive 
        ALUOp = 3'b010; 
        R2 = 32'hF207994D; //  binary = 11110010000001111001100101001101 
        R3 = 32'h06A4290A ; //decimal = 111421706 binary = 0110101001000010100100001010 
        //output 
        //decimal:  -122961321
        //HEX: F8ABC257
        
         #50; //ADD small 
        ALUOp = 3'b010; 
        R2 = 32'h0000000F; //  decimal = 15 binary = 0000 0000 0000 0000 0000 0000 0000 1111 
        R3 = 32'h0000000A ; //decimal = 10 binary = 0000 0000 0000 0000 0000 0000 0000 1010 
        //output 
        //decimal:  25
        //HEX: 
        
        #50; //ADD overlfow
        ALUOp = 3'b010; 
        R2 = 32'hFFFFFFFF; //decimal = 4294967295  binary =  1111 1111 1111 1111 1111 1111 1111 1111
        R3 = 32'h0000000B ; //decimal = 10 binary = 0000 0000 0000 0000 0000 0000 0000 1010 
        //output: 
        //binary 
        //decimal:  10
        //HEX: 0000000a 
        
        #50; //ADD NO overlfow
        ALUOp = 3'b010; 
        R2 = 32'hFab12341; 
        R3 = 32'h00BC1234 ;  
          
        
        #50; //ADD random
        ALUOp = 3'b010; 
        R2 = 32'hD207994D; //decimal = 3523713357  binary = 11010010000001111001100101001101 
        R3 = 32'h96A4290A ; //decimal = 2527340810 binary = 10010110101001000010100100001010 
        //output: 
        //binary 
        //decimal:  1756086871
        //HEX: 68abc257
        
        #50; //ADD zero
        ALUOp = 3'b010; 
        R2 = 32'hD207994D; //unsigned decimal = 3523713357  binary = 11010010000001111001100101001101 
        R3 = 32'h0 ; //decimal = 0 binary = 0000 0000 0000 0000 0000 0000 0000 0000 
        //output: D207994D
        //binary 
        //signed decimal: -771253939  
        //HEX: D207994D
        
       #50; //SUB random
        ALUOp = 3'b011; 
        R2 = 32'hD207994D; //decimal = 3523713357  binary = 11010010000001111001100101001101
        R3 = 32'h96A4290A ; //decimal = 2527340810 binary = 10010110101001000010100100001010 
        //output: binary 
        //decimal:  
        //HEX:
        
        #50; //SUB  zero
        ALUOp = 3'b011; 
        R2 = 32'hD207994D; //decimal = 3523713357  binary = 11010010000001111001100101001101
        R3 = 32'h0 ; //decimal = 0 binary = 0000 0000 0000 0000 0000 0000 0000 0000 
        //output: binary 
        //signed decimal: -771253939  
        //HEX:D207994D
        
        #50; //SUB  same
        ALUOp = 3'b011; 
        R2 = 32'hD207994D; //decimal = 3523713357  binary = 11010010000001111001100101001101
        R3 = 32'hD207994D ; //decimal = 3523713357  binary = 11010010000001111001100101001101 
        //output: binary 
        //signed decimal: 0  
        //HEX:00000000 
        
         #50; //SUB  pos answer
        ALUOp = 3'b011; 
        R2 = 32'h00012345; //decimal =   binary = 
        R3 = 32'h0000000F ; //decimal =   binary =  
        //output: binary 
        //signed decimal: 
        //HEX:
        
         #50; //SUB  neg answer
        ALUOp = 3'b011; 
        R2 = 32'h0000000F; //decimal =   binary = 
        R3 = 32'h00012345 ; //decimal =   binary =  
        //output: binary 
        //signed decimal:   
        //HEX: 
        
        #50; //OR random values
        ALUOp = 3'b100; 
        R2 = 32'hb3dff0d7;// decimal:    binary:
        R3 = 32'h1c17d36b;// decimal:    binary:
        //output: binary 
        //decimal:  
        //HEX:
        
        #50; //AND random values 
        ALUOp = 3'b101; 
        R2 = 32'hee5b64d2;// decimal:    binary: 
        R3 = 32'h07ef2d40; // decimal:    binary:
        //output: binary 
        //decimal:  
        //HEX:
   end 
   
endmodule
