`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:55:26 11/12/2021 
// Design Name: 
// Module Name:    sensor_input 
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
module media_2(
	output reg [7:0] h_medie,
	output reg h_rest,
	input [7:0] sens1,
	input [7:0] sens2);
	
	reg [8:0] sum;
		
	always @(*) begin
		if (sens1 == 0 || sens2 == 0) begin
			sum = 0;			// conditia daca un senzor este = 0 
			h_medie = 0;
			h_rest = 0;
		end else begin
			sum = sens1 + sens2;
			h_medie = sum/2;   
		
			if (sum[0] == 1)    //daca ultimul bit este 1 este numar impar
				h_rest = 1;  	  //=> are rest
			else 
				h_rest = 0;
		end
			
	end
endmodule


module media_4(
	output reg [7 : 0] h,
   input    [7 : 0]   s1,
   input    [7 : 0]   s2,
   input    [7 : 0]   s3,
   input    [7 : 0]   s4);
	
	wire [7 : 0]   h1;
	wire [7 : 0]   h2;
	wire [8 : 0]   sum;
	
	media_2 M1 (h1, h1_rest, s1, s3); 
	media_2 M2 (h2, h2_rest, s2, s4);
	
	assign sum = h1 + h2;
	
	always @(*) begin
		if (h1 != 0 && h2 != 0) begin 				 
			if (h1_rest == 1 && h2_rest == 1) begin //daca ambele medii au rest => 0.5 + 0.5 = 1
				h = sum/2 + 1;						 		 //1/2 = 0.5 => se aduna 1 pentru aproximare
			end else if (h1_rest == 0 && h2_rest == 0) begin
				if (sum[0] == 1)							 //se verifica daca suma celor 2 medii este impara
					h = sum/2 + 1;							 //daca da aproximam 0.5 (restul impartirii) -> 1
				else h = sum/2;
			end else if (h1_rest == 1 || h2_rest == 1) begin
				if (sum[0] == 1)							
					h = sum/2 + 1;
				else h = sum/2;				//daca avem doar un rest 0.25 -> 0
			end
		end else if (h1 == 0) begin  
			if (h2_rest == 0) begin
				h = h2;					 		
			end else begin
				h = h2 + 1;				 		//daca exista rest => adunam un 1 pentru a aproxima 0.5 de la rest
			end
		end else begin 
			if (h1_rest == 0) begin
				h = h1;
			end else begin 
				h = h1 + 1;
			end
		end
	end
endmodule	
	

module sensors_input(
   output   [7 : 0]   height,
   input    [7 : 0]   sensor1,
   input    [7 : 0]   sensor2,
   input    [7 : 0]   sensor3,
   input    [7 : 0]   sensor4);
	
	media_4 M4(height, sensor1, sensor2, sensor3, sensor4);

endmodule
