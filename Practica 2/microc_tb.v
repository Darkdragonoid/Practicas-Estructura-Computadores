`timescale 1 ns / 10 ps
module microc_tb;
	reg clk;
	reg reset, t_s_inc, t_s_inm, t_we3, t_wez;	
	reg [2:0] t_op;
	wire t_z;
	wire [5:0] t_opcode;
	
	//instanciamos el módulo a instanciar
	microc pmicroc(clk, reset, t_s_inc, t_s_inm, t_we3, t_wez, t_op, t_z, t_opcode);
	
	always 
	begin
		#10
		clk=~clk;
	end
	
	initial
	begin
	$dumpfile("microc.vcd");
	$dumpvars;
	clk=1'b1;
	t_s_inc=1'b0;
	t_s_inm=1'b0;
	t_we3=1'b0;
	t_wez=1'b0;
	t_op=3'b000;
	end
	
	initial
	begin
	
	reset=1'b1;
	#5
	reset=1'b0;
	end

	initial 
	begin

	#10
	
	//cargas de inmediatos
	t_s_inc=1'b1;
	t_s_inm=1'b1;
	t_we3=1'b1;
	t_wez=1'b0;
	t_op=3'b000;
	
	//salto
	#40
	t_s_inc=1'b0;
	t_s_inm=1'b0;
	t_we3=1'b0;
	t_wez=1'b0;
	t_op=3'b000;
	
	//resta
	#20
	t_s_inc=1'b1;
	t_s_inm=1'b0;
	t_we3=1'b1;
	t_wez=1'b0;
	t_op=3'b011;
	
	//JNZ
	#20
	t_s_inc=1'b0;
	t_s_inm=1'b0;
	t_we3=1'b0;
	t_wez=1'b0;
	t_op=3'b000;
	
	//suma
	#20
	t_s_inc=1'b1;
	t_s_inm=1'b0;
	t_we3=1'b1;
	t_wez=1'b0;
	t_op=3'b010;
	
	//resta
	#20
	t_s_inc=1'b1;
	t_s_inm=1'b0;
	t_we3=1'b1;
	t_wez=1'b0;
	t_op=3'b011;
	
	//JNZ
	#20
	t_s_inc=1'b1;
	t_s_inm=1'b0;
	t_we3=1'b0;
	t_wez=1'b1;
	t_op=3'b000;
	
	//cargas de inmediatos
	#20
	t_s_inc=1'b1;
	t_s_inm=1'b1;
	t_we3=1'b1;
	t_wez=1'b1;
	t_op=3'b000;
	#10
	$finish;
	end
endmodule