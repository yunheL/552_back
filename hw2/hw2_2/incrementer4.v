module incrementer4(A,Out,Cin,Cout,P);
input [3:0]A;
input Cin;
output [3:0]Out ;
output Cout,P;

wire p0,p1,p2,p3;
wire c1,c2,c3;

assign p0 = A[0];
assign p1 = A[1];
assign p2 = A[2];
assign p3 = A[3];

assign Out[0] = (Cin&~A[0])|(~Cin&A[0]);
assign Out[1] = (c1&~A[1])|(~c1&A[1]);
assign Out[2] = (c2&~A[2])|(~c2&A[2]);
assign Out[3] = (c3&~A[3])|(~c3&A[3]);

assign c1 = p0&Cin;
assign c2 = p0&p1&Cin;
assign c3 = c2&p2&Cin;
assign P =  c3&p3&Cin;

endmodule
