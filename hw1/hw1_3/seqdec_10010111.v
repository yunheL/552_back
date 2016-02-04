module seqdec_10010111 (InA, Clk, Reset, Out);

input Clk;
input Reset;
input InA;

output Out;

wire [3:0] state;
wire [3:0] next_state;

statereg state_reg(
  .state(state),
  .next_state(next_state),
  .Clk(Clk),
  .Reset(Reset)
);

statelogic st_logic(
  .next_state(next_state),
  .Out(Out),
  .state(state),
  .InA(InA)
);

endmodule