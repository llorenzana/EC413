`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2022 08:51:23 AM
// Design Name: 
// Module Name: sixtyfourbitRCA_tb
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


module sixtyfourbitRCA_tb(

    );
    
    
    // Inputs
	reg [63:0] a;
	reg [63:0] b;
	reg c_in;
	
	reg clk;

	// Outputs
	wire c_out;
	wire [63:0] sum;
	wire c_out_verify;
	wire [63:0] sum_verify;
	wire error_flag;


	// Instantiate the Unit Under Test (UUT)
	sixtyfourbitRCA FA (
		.c_out(c_out), 
		.sum(sum), 
		.a(a), 
		.b(b), 
		.c_in(c_in)
	);
	
	// Verification module
	Verification_64bit Verification (
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
		
		a = 64'h0;
		b = 64'h0;
		c_in = 1'b0;

		// Wait 10 ns
		#100;
		//timing a)
		a = 64'hFFFFFFFFFFFFFFFF;
		b = 64'hFFFFFFFFFFFFFFFF;
		c_in = 1'b0;

        #100;
		a = 64'hFFFFFFFFFFFFFFFF;
		b = 64'hFFFFFFFFFFFFFFFF;
		c_in = 1'b1;
		
		#100;
		//timing b)
		a = 64'h6A;
		b = 64'h4;
		c_in = 1'b0;
		
		#100;
		//timing c)
		a = 64'hF;
		b = 64'hF;
		c_in = 1'b1;

        #100 
        //timing d)
        a = 64'h508BBE0301D2D287;
        b = 64'hDF181EA770DB8BB5;
        c_in = 1'b0;
        
        #100
        $finish;

	end
endmodule
