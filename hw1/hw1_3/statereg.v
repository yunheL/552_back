//code referenced Prof. Karu's lecture material
//on 01/28, material is on course website
module statereg (state, next_state, Clk, Reset);

input [3:0] next_state;
output [3:0] state;

input Clk;
input Reset;

dff state_flops[3:0] (
  .d(next_state),
  .q(state),
  .clk(Clk),
  .rst(Reset)
);

endmodule