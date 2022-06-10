`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:04 11/13/2021 
// Design Name: 
// Module Name:    square_root 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module square_root_intreg( 
	output reg [3:0] intreg,
	output reg [5:0] aux1, 
	output reg [5:0] aux2,
	input [7:0] nr);
	
	wire [1:0] b;
	reg [2:0] i;
	reg [3:0] j;

	assign b = 2'b01;   
	
	always @(*) begin
		aux1 = 6'b0;
		aux2 = b;
		intreg = 4'b0; 
		j = 7;
		
		for (i = 0; i < 4; i = i + 1) begin 
			aux1 = aux1 << 2; //se shifteaza cu 2 pentru a putea adauga urmatorii 2 biti, 
									//si pentru a scoate zerourile de la inceput
			aux1 = {aux1[5:2],nr[j],nr[j-1]};  //se adauga perechi de biti din numar incepand cu poz 7
			if (aux1 >= aux2) begin  
				aux1 = aux1 - aux2;  
				intreg = intreg << 1;  
				intreg = {intreg[3:1],1'b1}; //daca aux1 >= aux2 => adaugam un 1 la rezultat
			end else if (aux1 < aux2) begin 
				intreg = intreg << 1; //daca nu se poate face diferenta => adaugam un 0(shiftam)
			end
			aux2 = {intreg, b}; 
			j = j - 2; // am folosit un j pentru ca am observat ca nu pot sa iau un for descrescator
		end
	end
endmodule

module square_root_zecimal( 
	output reg [15:0] s_r,	  
	input [7:0] nr);
	
	wire [3:0] intreg;		  
	wire [5:0] a1;
	wire [5:0] a2;
	
	square_root_intreg S1(intreg, a1, a2, nr); 
	
	wire [1:0] b;
	reg [13:0] aux1;
   reg [13:0] aux2;
	reg [11:0] zecimal; 
	reg [3:0] i;
	reg [4:0] j;
	
	assign b = 2'b01;
	
	always @(*) begin
		aux1 = a1;			  //initial aux1 = a1
		aux2 = a2;			  //aux2 = a2 
		zecimal = intreg;   //zecimal = intreg pentru a putea continua calculale de unde s-a oprit square_root_intreg
		j = 15;				  
		
		if (aux1 != 0) begin
			for (i = 0; i < 8; i = i + 1) begin 
				aux1 = aux1 << 2; //aux1 doar se shifteaza deoarece i sa adauga doar zerouri
				if (aux1 >= aux2) begin
					aux1 = aux1 - aux2;
					zecimal = zecimal << 1;
					zecimal = {zecimal[11:1],1'b1};
				end else if (aux1 < aux2) begin 
					zecimal = zecimal << 1;
				end
				aux2 = {zecimal, b};
				j = j - 2;
			end
			s_r = zecimal; //la final zecimal o sa aibe partea intreaga si cea zecimala
		end else begin
			s_r = intreg;  
			s_r = s_r << 8; //se shifteaza cu 8 pentru a ajunge pe pozitia partii intregi
		end
	end
endmodule
	
	
module square_root(
	output [15:0] out,
   input  [7:0] in);
	
	square_root_zecimal SR(out, in);
	
endmodule
