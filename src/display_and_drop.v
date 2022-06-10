`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:10:11 11/14/2021 
// Design Name: 
// Module Name:    display_and_drop 
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
module display_and_drop(
    output   [6 : 0]   seven_seg1, 
    output   [6 : 0]   seven_seg2,
    output   [6 : 0]   seven_seg3,
    output   [6 : 0]   seven_seg4,
    output   [0 : 0]   drop_activated,
    input    [15: 0]   t_act,
    input    [15: 0]   t_lim,
    input              drop_en);
	 
	 
	 reg [6:0] seven_seg_reg1;
	 reg [6:0] seven_seg_reg2;
	 reg [6:0] seven_seg_reg3;
	 reg [6:0] seven_seg_reg4;
	 reg [2:0] num;
	 reg drop;
	 
	 always @(*) begin 
			if ( drop_en == 0 && (t_act <= t_lim)) begin
				drop = 0; // conditia de COLD
				seven_seg_reg1 = 7'b011_1001;
				seven_seg_reg2 = 7'b101_1100;
				seven_seg_reg3 = 7'b011_1000;
				seven_seg_reg4 = 7'b101_1110;
			end
			if ( drop_en == 1 && (t_act <= t_lim)) begin
				drop = 1; // conditia de DROP
				seven_seg_reg1 = 7'b101_1110;
				seven_seg_reg2 = 7'b101_0000;
				seven_seg_reg3 = 7'b101_1100;
				seven_seg_reg4 = 7'b111_0011;
			end
			if ( drop_en == 1 && (t_act > t_lim)) begin
				drop = 0; // conditia de _HOT
				seven_seg_reg1 = 7'b000_0000;
				seven_seg_reg2 = 7'b111_0110;
				seven_seg_reg3 = 7'b101_1100;
				seven_seg_reg4 = 7'b111_1000;
			end
	 end
	 
	 assign drop_activated = drop;
	 assign seven_seg1 = seven_seg_reg1;
	 assign seven_seg2 = seven_seg_reg2;
	 assign seven_seg3 = seven_seg_reg3;
	 assign seven_seg4 = seven_seg_reg4;
endmodule	