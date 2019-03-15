
module cl(output wire out, input wire a, b, input wire [1:0] s);
wire p_and, p_not, p_or, p_xor;

  and and1 (p_and, a, b);
  or or1 (p_or, a, b);
  xor xor1(p_xor, a, b);
  not not1 (p_not, a); 																																																																																																																																																																

  mux4_1 mux1(out, p_and, p_or, p_xor, p_not, s);

endmodule
