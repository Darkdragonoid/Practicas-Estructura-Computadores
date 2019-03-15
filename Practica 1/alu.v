`include"cal.v"
`include"cl.v"
`include"compl1.v"
`include"fa.v"
`include"mux2_1.v"
`include"mux2_4.v"
`include"mux4_1.v"

module alu(output wire [3:0] R, output wire zero, carry, sign, input wire [3:0] A, B, input wire [1:0] ALUOp, input wire arit);

	//bloque de mux y complemento
	
	wire [3:0] OP1, OP2, smux;
	wire op1_A, op2_B, cpl;
	wire c_out0, c_out1, c_out2, c_out3, cin0;

	//asignacion a los valores de cin0, cpl, op1_A y op2_B con fuciones calculadas por tablas de karnaugh

	assign cpl = arit & ALUOp[0] | arit & ALUOp[1];
	assign op1_A = ~arit | ~ALUOp[1];
	assign op2_B =~ALUOp[1] | ALUOp[0] | ~arit;
	assign cin0 = ALUOp[0] | ALUOp[1];

	mux2_4 mux1(OP1, 4'b0000,  A, op1_A);
	mux2_4 mux2(smux, A, B, op2_B);
	compl1 c1(OP2, smux, cpl);
	
	//asignacion de los valores sign, carry y zero (en referencia a la tabla proporcionada)
	/*assign sign = arit ? R[3] : 1'dx;*/assign sign = R[3];
	/*assign carry = arit ? c_out3 : 1'dx;*/assign carry = c_out3;
	//assign zero = (R==4'b0000) ? 1 : 0;
	wire sal1, sal2, sal3;
	
	or or1(sal1, R[3], R[2]);
	or or2(sal2, R[1], R[0]);
	or or3(sal3, sal1, sal2);
	not not1(zero, sal3);
	
	//bloques CAL	

	cal cal0(R[0], c_out0, OP1[0], OP2[0], arit, cin0, ALUOp);
	cal cal1(R[1], c_out1, OP1[1], OP2[1], arit, c_out0, ALUOp);
	cal cal2(R[2], c_out2, OP1[2], OP2[2], arit, c_out1, ALUOp);
	cal cal3(R[3], c_out3, OP1[3], OP2[3], arit, c_out2, ALUOp);
	
endmodule
