module fulladder16(SUM, CO, A, B, CI);

  input [15:0] A;
  input [15:0] B;
  input CI;
  output [15:0] SUM;
  output CO;
  wire Im0, Im1, Im2;

  FA_4 FA4_A(.S(SUM[3:0]), .CO(Im0), .A(A[3:0]), .B(B[3:0]), .CI(CI));
  FA_4 FA4_B(.S(SUM[7:4]), .CO(Im1), .A(A[7:4]), .B(B[7:4]), .CI(Im0));
  FA_4 FA4_C(.S(SUM[11:8]), .CO(Im2), .A(A[11:8]), .B(B[11:8]), .CI(Im1));
  FA_4 FA4_D(.S(SUM[15:12]), .CO(CO), .A(A[15:12]), .B(B[15:12]), .CI(Im2));

endmodule 
