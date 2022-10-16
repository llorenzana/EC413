`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2022 17:13:39
// Design Name: 
// Module Name: thirtytwobitRCA_D_tb
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


module thirtytwobitRCA_D_tb(

    );
    // Inputs
	reg [31:0] a;
	reg [31:0] b;
	reg c_in;
	
	reg clk;

	// Outputs
	wire c_out;
	wire [31:0] sum;
	wire c_out_verify;
	wire [31:0] sum_verify;
	wire error_flag;


	// Instantiate the Unit Under Test (UUT)
	thirtytwobitRCA_D FA (
		.c_out(c_out), 
		.sum(sum), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Verification module
	Verification_32bit Verification (
		.c_out(c_out_verify), 
		.sum(sum_verify), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Assign Error_flag
	assign error_flag = (c_out != c_out_verify || sum != sum_verify);
	
		// Derfine clk signal for Verfication purpose
	always #5 clk = ~clk;

	// Verification logic
	always@(posedge clk)
		begin
		if(error_flag)
			// Use $display here instead of $monitor
			// $monitor will display the message whenever there's a change of a, b, c_in
			// $display will only display once when it's been executed
			$display("Error occurs when a = %d, b = %d, c_in = %d\n", a, b, c_in);
		end
		
	initial begin
		// Initialize Inputs
		clk = 0;
		
		a = 32'h0;
		b = 32'h0;
		c_in = 1'b0;

		// Wait 10 ns
		#100;
		//timing a)
		a = 32'hFFFFFFFF;
		b = 32'hFFFFFFFF;
		c_in = 1'b0;

        #100;
		a = 32'hFFFFFFFF;
		b = 32'hFFFFFFFF;
		c_in = 1'b1;
		
		#100;
		//timing b)
		a = 32'h6A;
		b = 32'h4;
		c_in = 1'b0;
		
		#100;
		//timing c)
		a = 32'hF;
		b = 32'hF;
		c_in = 1'b1;

        #100 
        //timing d)
        a = 32'h508BBE03;
        b = 32'hDF181EA7;
        c_in = 1'b0;
        
        #100
        $finish;
     end
endmodule
