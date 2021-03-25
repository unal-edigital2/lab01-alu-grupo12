module Restador(A, B, init, Ans, done, clk, sig);

  input init;
  input clk;
  input [2:0] A;
  input [2:0] B;
  
  output reg sig;
  output reg[3:0] Ans;
  output reg done;

  reg [2:0] CompA1;
  reg [3:0] s;
always@(posedge clk) begin
	if (init) begin
 		CompA1=~B;
		s=A+CompA1+1;
		if (s[3]==0) begin sig=1; Ans=	~(s-1); done=1; end
		else begin sig=0; Ans=s; done=1; end
	   end
	end
endmodule