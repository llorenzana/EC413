`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2022 17:24:22
// Design Name: 
// Module Name: sixteenbitRCA_D_tb
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


module sixteenbitRCA_D_tb(

    );
    // Inputs
	reg [15:0] a;
	reg [15:0] b;
	reg c_in;
	
	reg clk;

	// Outputs
	wire c_out;
	wire [15:0] sum;
	wire c_out_verify;
	wire [15:0] sum_verify;
	wire error_flag;


	// Instantiate the Unit Under Test (UUT)
	sixteenbitRCA_D_tb FA (
		.c_out(c_out), 
		.sum(sum), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Verification module
	Verification_16bit Verification (
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
		
		a = 16'h0;
		b = 16'h0;
		c_in = 1'b0;

		// Wait 10 ns
		#100;
		//timing a)
		a = 16'hFFFF;
		b = 16'hFFFF;
		c_in = 1'b0;

        #100;
		a = 16'hFFFF;
		b = 16'hFFFF;
		c_in = 1'b1;
		
		#100;
		//timing b)
		a = 16'h6A;
		b = 16'h4;
		c_in = 1'b0;
		
		#100;
		//timing c)
		a = 16'hF;
		b = 16'hF;
		c_in = 1'b1;

        #100 
        //timing d)
        a = 16'h508B;
        b = 16'hDF18;
        c_in = 1'b0;
        
        #100
        $finish;

	end
endmodule
