
`define	D		1	// definition of the delay

// Delayed AND gate

module AND_D_3(out, in1, in2, in3);

input in1, in2, in3;
output out;

and		#`D		and1(out, in1, in2, in3);

endmodule