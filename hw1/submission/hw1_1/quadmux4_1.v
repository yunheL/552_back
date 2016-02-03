module quadmux4_1(Out, InA, InB, InC, InD, S);

  input [3:0] InA;
  input [3:0] InB;
  input [3:0] InC;
  input [3:0] InD;
  input [1:0] S;
  output [3:0] Out;
 
  mux4_1 mux4_A(.Out(Out[0]), .InA(InA[0]), .InB(InB[0]), .InC(InC[0]), .InD(InD[0]), .S(S));
  mux4_1 mux4_B(.Out(Out[1]), .InA(InA[1]), .InB(InB[1]), .InC(InC[1]), .InD(InD[1]), .S(S));
  mux4_1 mux4_C(.Out(Out[2]), .InA(InA[2]), .InB(InB[2]), .InC(InC[2]), .InD(InD[2]), .S(S));
  mux4_1 mux4_D(.Out(Out[3]), .InA(InA[3]), .InB(InB[3]), .InC(InC[3]), .InD(InD[3]), .S(S));
  
endmodule
