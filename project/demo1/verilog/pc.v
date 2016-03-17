module pc(en,clk,rst,jump,inst,addr,zero,branch,rs);

input en, clk, rst, jump,zero,branch;
input[15:0] inst;
input [15:0] rs;
output [15:0] addr;
//output [15:0] writeregdata;


wire [15:0] pc_wb, nxt_pc, branch_pc, jmp_pc;
wire br_ctl;
wire [15:0] br_inst, br_out;
wire [15:0] jmp_d, jmp_i, jmp_out;

reg16 pc_dff(.read(addr),.write(pc_wb),.wr_en(en),.rst(rst),.clk(clk));
CLA16 pc_incr(.A(addr),.B(16'h0002),.Cin(1'b0),.Cout(),.S(nxt_pc));

CLA16 br_add(.A(nxt_pc),.B(br_inst),.Cin(1'b0),.Cout(),.S(br_out));

assign br_ctl = branch&zero;
assign br_inst = {{8{inst[7]}}, inst[7:0]};

CLA16 br_add_d(.A(nxt_pc),.B({{5{inst[10]}},inst[10:0]}),.Cin(1'b0),.Cout(),.S(jmp_d));
CLA16 br_add_i(.A(rs),.B({{8{inst[7]}},inst[7:0]}),.Cin(1'b0),.Cout(),.S(jmp_i));
assign jmp_out = (inst[11])? jmp_i:jmp_d;
assign pc_wb = (jump)? jmp_out : br_out;

endmodule
