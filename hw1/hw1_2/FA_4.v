module FA_4(S, CO, A, B, CI);

  input [3:0] A;
  input [3:0] B;
  input CI;
  output [3:0] S;
  output CO;
  wire Im0, Im1, Im2;

  FA_1 FA1_A(.S(S[0]), .Cout(Im0), .A(A[0]), .B(B[0]), .Cin(CI));
  FA_1 FA1_B(.S(S[1]), .Cout(Im1), .A(A[1]), .B(B[1]), .Cin(Im0));
  FA_1 FA1_C(.S(S[2]), .Cout(Im2), .A(A[2]), .B(B[2]), .Cin(Im1));
  FA_1 FA1_D(.S(S[3]), .Cout(CO), .A(A[3]), .B(B[3]), .Cin(Im2));

endmodule 
