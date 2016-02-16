module incrementer16(A,Out);

input [15:0]A;
output [15:0]Out;

wire c1,c2,c3;
wire p0,p1,p2,p3;
incrementer4 I0 (.A(A[3:0]),.Out(Out[3:0]),.Cout(),.P(p0),.Cin(1'b1));
incrementer4 I1 (.A(A[7:4]),.Out(Out[7:4]),.Cout(),.P(p1),.Cin(c1));
incrementer4 I2 (.A(A[11:8]),.Out(Out[11:8]),.Cout(),.P(p2),.Cin(c2));
incrementer4 I3 (.A(A[15:12]),.Out(Out[15:12]),.Cout(),.P(p3),.Cin(c3));

assign c1= p0;
assign c2 = c1&p1;
assign c3 = c2&p2;
endmodule
