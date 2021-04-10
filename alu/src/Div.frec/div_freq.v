module div_freq(clk,clk_1);
 
input clk;
output  clk_1;
reg clk_1;
reg [27:0] cont;

always @ (posedge clk)
begin
cont=cont+1;

if(cont ==1000_000)begin
cont=0;
clk_1=~clk_1;
end

end
endmodule
