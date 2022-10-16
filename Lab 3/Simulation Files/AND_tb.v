`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2022 17:52:55
// Design Name: 
// Module Name: AND_tb
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


module AND_tb(

    );
    
    // Inputs
	reg a;
	reg b;

	// Outputs
	wire out;
	
	AND_T AND(
	   .in1(a),
	   .in2(b),
	   .out(out)
	);



	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;

		// Wait 10 ns
		#10;
		a = 1;
		b = 0;

		// Wait 10 ns
		#10;
		a = 0;
		b = 1;

		// Wait 10 ns
		#10;
		a = 1;
		b = 1;

	end
endmodule
