module Verification_32bit(
    output c_out,
    output [31:0] sum,
    input [31:0] a,
    input [31:0] b,
    input c_in
    );
    
	assign {c_out, sum} = a + b + c_in;
	
endmodule
