`timescale 1ns / 1ns

module control(
		input [5:0] instruction,
		output reg [1:0] ALUOp,
		output reg MemRead,
		output reg MemtoReg,
		output reg RegDst,
		output reg Branch, 
		output reg ALUSrc,
		output reg MemWrite,
		output reg RegWrite,
		output reg J, //task 4
		output reg BNE, // task 5
		output reg LUI // task 6
		);


always @(*) begin
		if (instruction == 6'b00_0000) begin				//RType
		  ALUOp = 2'b00;
		  MemRead = 1'b0;
		  MemtoReg = 1'b0;
		  RegDst = 1'b1;
          Branch = 1'b0;		
	      ALUSrc = 1'b0;
		  MemWrite = 1'b0;
		  RegWrite = 1'b1;
		  J = 1'b0;
		  BNE = 1'b0;
		  LUI = 1'b0;
		
		end else if (instruction == 6'b00_0100) begin   //branch
		  ALUOp = 2'b01;
		  MemRead = 1'b0;
		  MemtoReg = 1'b0;
		  RegDst = 1'b0;
          Branch = 1'b1;		
	      ALUSrc = 1'b0;
		  MemWrite = 1'b0;
		  RegWrite = 1'b0;
		  J = 1'b0;
		  BNE = 1'b0;
		  LUI = 1'b0;
		  
		end else if (instruction == 6'b10_1011) begin   // sw
		  ALUOp = 2'b10;
		  MemRead = 1'b0;
		  MemtoReg = 1'b0;
		  RegDst = 1'b0;
          Branch = 1'b0;		
	      ALUSrc = 1'b1;
		  MemWrite = 1'b1;
		  RegWrite = 1'b0;
		  J = 1'b0;
		  BNE = 1'b0;
		  LUI = 1'b0;
		  
		end else if (instruction == 6'b10_0011) begin   // lw
		  ALUOp = 2'b10;
		  MemRead = 1'b1;
		  MemtoReg = 1'b1;
		  RegDst = 1'b0;
          Branch = 1'b0;		
	      ALUSrc = 1'b1;
		  MemWrite = 1'b0;
		  RegWrite = 1'b1;
		  J = 1'b0;
		  BNE = 1'b0;
		  LUI = 1'b0;
		  
		end else if (instruction == 6'b00_1000) begin   // ADDI = (8)_10
		  ALUOp = 2'b10; // Add function
		  MemRead = 1'b0; // Not needed for immediate
		  MemtoReg = 1'b0; // not needed fop immediate 
		  RegDst = 1'b0; // write result to readReg2
          Branch = 1'b0;		
	      ALUSrc = 1'b1;
		  MemWrite = 1'b0; // not writing to memory 
		  RegWrite = 1'b1; //write result to a reg 
		  J = 1'b0;
		  BNE = 1'b0;
		  LUI = 1'b0;
		  
	    end else if (instruction == 6'b00_0010) begin   // Jump = (2)_10
	     // Everything should be set to 0 excoet for J and ALUOp
		  ALUOp = 2'b11; // don't care
		  MemRead = 1'b0; 
		  MemtoReg = 1'b0;  
		  RegDst = 1'b0; 
          Branch = 1'b0;		
	      ALUSrc = 1'b0;
		  MemWrite = 1'b0;  
		  RegWrite = 1'b0; 
		  J = 1'b1;
		  BNE = 1'b0;
		  LUI = 1'b0;
		 
		 end else if (instruction == 6'b00_0101) begin   // BNE = (5)_10
		  ALUOp = 2'b01; // similar to BEQ - using SUB
		  MemRead = 1'b0; 
		  MemtoReg = 1'b0;  
		  RegDst = 1'b0; 
          Branch = 1'b1;	//BNE is a branch function	
	      ALUSrc = 1'b0;
		  MemWrite = 1'b0;  
		  RegWrite = 1'b0; 
		  J = 1'b0;
		  BNE = 1'b1; // set to 1 
		  LUI = 1'b0; 
		  
		end else if (instruction == 6'b00_1111) begin   // LUI = (15)_10
		  ALUOp = 2'b10; // want to use ADD 
		  MemRead = 1'b1; //read 4 upper bits from memory 
		  MemtoReg = 1'b0;  
		  RegDst = 1'b0; 
          Branch = 1'b0;	//BNE is a branch function	
	      ALUSrc = 1'b1;
		  MemWrite = 1'b0;  
		  RegWrite = 1'b1; //Writing result to memory 
		  J = 1'b0;
		  BNE = 1'b0;  
		  LUI = 1'b1; //Performing LUI Function
		    
		end else begin // set everything to 0
		  ALUOp = 2'b00;
		  MemRead = 1'b0;
		  MemtoReg = 1'b0;
		  RegDst = 1'b0;
          Branch = 1'b0;		
	      ALUSrc = 1'b0;
		  MemWrite = 1'b0;
		  RegWrite = 1'b0;
		  J = 1'b0;
		  BNE = 1'b0;  
		  LUI = 1'b0; 
	    end
	      
	
    end

endmodule
