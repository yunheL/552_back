module mux4_1(Out, InA, InB, InC, InD, S[1:0]);

  input InA;
  input InB;
  input InC;
  input InD;
  input [1:0] S;
  output Out;
  wire Im0, Im1;
  
  mux2_1 mux2_A(.Out(Im0), .InA(InA), .InB(InB), .S(S[0])); 
  mux2_1 mux2_B(.Out(Im1), .InA(InC), .InB(InD), .S(S[0])); 
  mux2_1 mux2_C(.Out(Out), .InA(Im0), .InB(Im1), .S(S[1]));

endmodule
