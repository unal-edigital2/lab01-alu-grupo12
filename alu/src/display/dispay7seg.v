`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2021 11:48:21
// Design Name: 
// Module Name: dispay7seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module display (num, clk, SSeg, an, rst);

  input [15:0] num;
  input clk;
  input rst;
  output reg [6:0] SSeg;
  output reg [3:0] an;


reg [3:0]BCD=0;

reg [26:0] cfreq=0;
wire enable;


assign enable = cfreq[16];

always @(posedge clk) begin
		cfreq <=cfreq+1;
end

reg [1:0] count =0;
always @(posedge enable) begin
			count<= count+1;
			an<=4'b1101;
			case (count)
				2'h0: begin BCD <= num[3:0];   an<=4'b1110; end
				2'h1: begin BCD <= num[7:4];   an<=4'b1101; end
				2'h2: begin BCD <= num[11:8];  an<=4'b1011; end
				2'h3: begin BCD <= num[15:12]; an<=4'b0111; end
			endcase
end




always @ ( * ) begin
  case (BCD)
    4'b0000: SSeg = 7'b1000000; // "0"
	4'b0001: SSeg = 7'b1111001; // "1"
	4'b0010: SSeg = 7'b0100100; // "2"
	4'b0011: SSeg = 7'b0110000; // "3"
	4'b0100: SSeg = 7'b0011001; // "4"
	4'b0101: SSeg = 7'b0010010; // "5"
	4'b0110: SSeg = 7'b0000010; // "6"
	4'b0111: SSeg = 7'b1111000; // "7"
	4'b1000: SSeg = 7'b0000000; // "8"
	4'b1001: SSeg = 7'b0011000; // "9"
       4'ha: SSeg = 7'b0001000; // "10"
       4'hb: SSeg = 7'b0000011; // "11"
       4'hc: SSeg = 7'b0100111; // "12"
       4'hd: SSeg = 7'b0100001; // "13"
       4'he: SSeg = 7'b0000100; // "14"
       4'hf: SSeg = 7'b0001110; // "15"
    default:
    SSeg = 0;
    endcase
end

endmodule