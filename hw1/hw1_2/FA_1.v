module FA_1(S, Cout, A, B, Cin);

  input A;
  input B;
  input Cin;
  output S;
  output Cout;
  wire Im0, Im1, Im2, Im3, Im4, Im5, Im6;

  xor3 xor3_A(.in1(Cin), .in2(A), .in3(B), .out(S));

  nor2 nor2_A(.in1(A), .in2(B), .out(Im0));
  not1 not1_A(.in1(Im0), .out(Im1));
  nand2 nand2_A(.in1(Im1), .in2(Cin), .out(Im2));
  not1 not1_B(.in1(Im2), .out(Im3));

  nand2 nand2_B(.in1(A), .in2(B), .out(Im4));
  not1 not1_C(.in1(Im4), .out(Im5));

  nor2 nor2_B(.in1(Im3), .in2(Im5), .out(Im6));
  not1 not1_D(.in1(Im6), .out(Cout));

endmodule 
