module cal(output wire out, c_out, input wire a, b, arit, c_in, input wire [1:0] s);

	wire salfa, salcl;

	fa sfa(c_out, salfa, a, b, c_in);

	cl scl(salcl, a, b, s);

	mux2_1 mux(out, salcl, salfa, arit);
		
endmodule




