module pc(en,clk,rst,jump,inst,addr,branch,rs,pc_nx);

input en, clk, rst, jump,branch;
input[15:0] inst;
input [15:0] rs;
output [15:0] addr;
output [15:0] pc_nx;
//output [15:0] writeregdata;

wire Z,N,P;
wire [15:0] pc_wb, nxt_pc;
wire br_ctl;
wire [15:0] br_inst, br_out,br_pre;
wire [15:0] jmp_d, jmp_i, jmp_out;

reg16 pc_dff(.read(addr),.write(pc_wb),.wr_en(en),.rst(rst),.clk(clk));
CLA16 pc_incr(.A(addr),.B(16'h0002),.Cin(1'b0),.Cout(),.S(nxt_pc));

CLA16 br_add(.A(nxt_pc),.B(br_inst),.Cin(1'b0),.Cout(),.S(br_pre));



  assign or0 = rs[0]|rs[1]|rs[2]|rs[3];
  assign or1 = rs[4]|rs[5]|rs[6]|rs[7];
  assign or2 = rs[8]|rs[9]|rs[10]|rs[11];
  assign or3 = rs[12]|rs[13]|rs[14]|rs[15];
  
  assign Z = ~(or0|or1|or2|or3);
  assign N = rs[15];
  assign P = ~(Z^N); 






assign br_ctl = ((inst[15:11]==5'b01100)&Z) ?1'b1:
                ((inst[15:11]==5'b01101)&(~Z))? 1'b1:
                ((inst[15:11]==5'b01110)&N)? 1'b1:
                ((inst[15:11]==5'b01111)&(Z|P))? 1'b1:
                1'b0;
assign br_inst = {{8{inst[7]}}, inst[7:0]};

CLA16 br_add_d(.A(nxt_pc),.B({{5{inst[10]}},inst[10:0]}),.Cin(1'b0),.Cout(),.S(jmp_d));
CLA16 br_add_i(.A(rs),.B({{8{inst[7]}},inst[7:0]}),.Cin(1'b0),.Cout(),.S(jmp_i));
assign jmp_out = (inst[11])? jmp_i:jmp_d;
assign br_out = (br_ctl)? br_pre:nxt_pc;
assign pc_wb = (jump)? jmp_out : br_out;
assign pc_nx = nxt_pc;
endmodule
