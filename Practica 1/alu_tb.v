// Testbench para modulo alu
`timescale 1 ns / 10 ps //Directiva que fija la unidad de tiempo de simulación y la precision de la unidad
module alu_tb;
//declaracion de señales
reg [1:0] t_Op;
reg t_Arit;
reg [3:0] t_A, t_B;
wire [3:0] t_R;
wire t_z, t_c, t_s;

//instancia del modulo a testear
alu mat(t_R, t_z, t_c, t_s, t_A, t_B, t_Op, t_Arit);

initial
begin
  $monitor;
  $dumpfile("alu.vcd");
  $dumpvars;
  $monitor("tiempo=%0d A=%b B=%b Arit=%b Op=%b R=%b, Z=%b, C=%b, S=%b", $time, t_A, t_B, t_Arit, t_Op, t_R, t_z, t_c, t_s);
  //vector de test 0, suma 1000 acarreo, negativo
  t_A = 4'b1010;
  t_B = 4'b1110;
  t_Op = 2'b00;
  t_Arit = 1'b1;
  # 20;
  check(4'b1000, 1'b0, 1'b1, 1'b1);
  
  //vector de test 1 suma 0000 cero, acarreo
  t_A = 4'b1010;
  t_B = 4'b0110;
  t_Op = 2'b00;
  t_Arit = 1'b1;
  # 20;
  check(4'b0000, 1'b1, 1'b1, 1'b0);
  
  //vector de test 2 resta 0000 cero
  // Este ejemplo sí da acarreo, pero se debería ignorar
  t_A = 4'b1010;
  t_B = 4'b1010;
  t_Op = 2'b01;
  t_Arit = 1'b1;
  # 20;
  check(4'b0000, 1'b1, 1'b1, 1'b0);
  
  //vector de test 3 com2 de B 0010
  t_A = 4'b1011;
  t_B = 4'b1110;
  t_Op = 2'b11;
  t_Arit = 1'b1;
  # 20;
  check(4'b0010, 1'b0, 1'b0, 1'b0);
  
  //vector de test 4 com2 de A 0010
  t_A = 4'b1110;
  t_B = 4'b1010;
  t_Op = 2'b10;
  t_Arit = 1'b1;
  # 20;
  check(4'b0010, 1'b0, 1'b0, 1'b0);
  
  //vector de test 5 and 1000
  t_A = 4'b1010;
  t_B = 4'b1100;
  t_Op = 2'b00;
  t_Arit = 1'b0;
  # 20;
  check(4'b1000, 1'b0, 1'bx, 1'bx);
  
  //vector de test 6 and 1110 (añadido por nosotros para comprobación de la operacion or.
  t_A = 4'b1010;
  t_B = 4'b1100;
  t_Op = 2'b01;
  t_Arit = 1'b0;
  # 20;
  check(4'b1110, 1'b0, 1'bx, 1'bx);
  
  //vector de test 7 xor 0110
  t_A = 4'b1010;
  t_B = 4'b1100;
  t_Op = 2'b10;
  t_Arit = 1'b0;
  # 20;
  check(4'b0110, 1'b0, 1'bx, 1'bx);
  
//vector de test 8 inv A 0101
  t_A = 4'b1010;
  t_B = 4'b1100;
  t_Op = 2'b11;
  t_Arit = 1'b0;
  # 20;
  check(4'b0101, 1'b0, 1'bx, 1'bx);
  
  //fin simulacion
  $finish;
end

// Tarea para hacer la comprobación automática de resultados
task check;
input [3:0] e_R;
input e_z, e_c, e_s;
begin
	// Si las operaciones son aritméticas
	if (t_Arit)
	begin
		if (({e_R, e_c, e_z, e_s} ^ {t_R, t_c, t_z, t_s}) !== 7'b0)
			$display("ERROR. Esperados  R=%b, Z=%b, C=%b, S=%b", e_R, e_z, e_c, e_s);
		else
			$display("CORRECTO");
	end
	else
	begin
		if (({e_R, e_z} ^ {t_R, t_z}) !== 5'b0)
			$display("ERROR. Esperados  R=%b, Z=%b, C=%b, S=%b", e_R, e_z, e_c, e_s);
		else
			$display("CORRECTO");
	end
end
endtask
endmodule
