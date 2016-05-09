module reg1(d,q,clk,rst,en);

input d, clk, rst,en;
output q;

wire d_in;

assign d_in = en? d:q;

dff d0 (.q(q),.d(d_in),.clk(clk),.rst(rst));

endmodule
