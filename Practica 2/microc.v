module microc(input wire clk, reset, s_inc, s_inm, we3, wez, input wire [2:0] op, output wire z, output wire [5:0] opcode);
//Microcontrolador sin memoria de datos de un solo ciclo

//Instanciar e interconectar pc, memprog, regfile, alu, sum, biestable Z y mux's

//CABLES
wire [9:0] s_sum;
wire [9:0] s_mux_suma;
wire [15:0] instruccion;
wire [9:0] direccion;
wire [7:0] rd1;
wire [7:0] rd2;
wire [7:0] s_alu;
wire [7:0] wd3;
wire z_alu;

assign opcode[5:0] = instruccion[15:10];
	
//INSTANCIACION DE MODULOS

//banco de registros(reloj, señal de selección we3, ra1, ra2, wa3, wd3(salida del mux),rd1 (entrada a la alu), rd2(entrada a la alu))
regfile banco_de_registros(clk,  we3, instruccion[11:8], instruccion[7:4], instruccion[3:0], wd3, rd1, rd2);

//sumador (1 codificado en 10b, salida del PC(etrada 2 del sumador), salida del sumador)
sum sumador(10'b0000000001, direccion, s_sum);

//mux del sumador (direccion_de_salto, salida del sumador, señal de selección s_inc, salida_mux_suma)
mux2 #(10) mux_suma (instruccion[9:0], s_sum, s_inc, s_mux_suma);

//mux de la alu( salida de la alu, inm(instruccion[11:4]), señal de selección s_inm, salida mux_alu)
mux2 mux_alu (s_alu, instruccion[11:4], s_inm, wd3);

//PC (reloj, reset salida_mux_suma, salida_PC(direccion))
registro #(10) PC (clk, reset, s_mux_suma, direccion);

//Banco de registro( reloj, salida_PC(direccion), instrucción(salida_memoria_programa))
memprog mem_prog(clk, direccion, instruccion);

//alu(rd1, rd2, señal de selección op, s_alu, z_alu)
alu m_alu(rd1, rd2, op, s_alu, z_alu);

//flip_flop_d(reloj, reset, z_alu, señal de selección wez, salida z)
ffd FFZ(clk, reset, z_alu, wez, z);

endmodule
