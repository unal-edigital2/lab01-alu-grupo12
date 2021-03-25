	
	module Divisor(DR, DV, init, clk, B, done);
	
	input [2:0] DR;
	input [2:0] DV;
	input	init;
	input	clk;
	output reg [2:0] B;
	output reg done;
	
	reg [1:0] C;
	reg sh;
	reg add;
	reg [5:0] A;
	reg [2:0] status;
	
	wire z;

	initial begin 
	A=0;
	C=3;
	B=0;
	end
	// bloque comparador
	
	assign z=(C==0)?1:0;
	
	// bloque de desplazamiento 
	
	always @ (negedge clk) begin
	
		if(init) begin 
		
			A={3'b000,DV}; // concatenacion 
			B=DV;
			C=3;
		end
		else begin
		if (sh) begin
			
			A={A[5:3],B}<<1;
			B=A[2:0];
			C=C-1;
			end
		end	
	// bloque de suma
		if(add) begin 
		
		A[5:3]=A[5:3]-DR;
		B[0]=1;
		
		end
	end
	// maquina de estados
	
	parameter START=0, CHECK=1, ADD=2, SHIFT=3, END=4;
	
	always @ (posedge clk) begin
		case(status)
		
			START: begin 
				sh=0; 
				add=0;
			if(init) begin 
				done=0;
			   status = SHIFT;
			end
			end
			
			CHECK: begin
				done=0;
				sh=0;
				add=0;
			if(A[5:3] < DR) begin
			if(z==0) status=SHIFT;
			else status=END;	
			end	
			else	status=ADD;
			end
			
			ADD: begin
				add=1;
				done=0;
				sh=0;
			if(z==0) status=SHIFT;
			else	status=END;
				end
				
			SHIFT: begin
				add=0;
				done=0;
			if(z==0)begin sh=1; status = CHECK; end
			else status=END;
			end
			
			END: begin
				add=0;
				done=1;
				sh=0;
				status=START;		
			end
			default: status=START;
			endcase
	end
	endmodule
