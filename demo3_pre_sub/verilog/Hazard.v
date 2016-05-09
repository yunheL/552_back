module Harzard(ID_rs, ID_rt, EX_rd,MEM_rd,ID_rs_v, ID_rt_v, EX_rd_v,MEM_rd_v,EX_inst,MEM_inst,fow_EXID_rs,fow_EXID_rt, fow_MEMID_rs,fow_MEMID_rt,memStall,memDone,memwrite,memread,stall,instMemStall,instMemDone,instMemDone_q,clk,rst);

input[2:0] ID_rs, ID_rt, EX_rd,MEM_rd;
input ID_rs_v, ID_rt_v, EX_rd_v,MEM_rd_v;
input [15:0] EX_inst;
input rst,clk;
input memStall,memDone;
input[15:0] MEM_inst;
input memread,memwrite;
input instMemStall,instMemDone,instMemDone_q;

output fow_EXID_rs,fow_EXID_rt, fow_MEMID_rs,fow_MEMID_rt;//foward signal from which stage to which rs/rt reg
output  stall;

//reg [1:0]stall_cnt;
//wire [1:0]stall_cnt_q;
wire stall_LD,stall_ST;
wire stall_st_d,stall_st_q;
wire stall_q;
wire memDone_q;
//data Hazard (most recent execution result)

dff stallq (.q(stall_q),.d(stall_d),.clk(clk),.rst(rst));
dff memDoneq(.q(memDone_q),.d(memDone),.clk(clk),.rst(rst));

assign fow_EXID_rs = (EX_rd_v&ID_rs_v&(EX_rd==ID_rs));
assign fow_EXID_rt = (EX_rd_v&ID_rt_v&(EX_rd==ID_rt));
assign fow_MEMID_rs = (MEM_rd_v&ID_rs_v&~(EX_rd_v&(EX_rd==MEM_rd))&(MEM_rd==ID_rs));
assign fow_MEMID_rt = (MEM_rd_v&ID_rt_v&~(EX_rd_v&(EX_rd==MEM_rd))&(MEM_rd==ID_rt));
/*
//stall 2 cycles
dff st_cnt0(.q(stall_cnt_q[0]),.d(stall_cnt[0]),.clk(clk),.rst(rst));
dff st_cnt1(.q(stall_cnt_q[1]),.d(stall_cnt[1]),.clk(clk),.rst(rst));
*/
//assign stall = stall_LD;
/*
always @ * begin
case(stall_LD)
  1'b1: 
  begin
  case(stall_cnt_q) 
    2'b00: 
    begin
      stall_cnt = 2'b01;
      stall = 1'b1;
    end
    2'b01:
    begin
      stall_cnt = 2'b10;
      stall = 1'b1;
    end
    2'b01: 
    begin
      stall_cnt = 2'b00;
      stall = 1'b0;
    end
    default: 
    begin
      stall_cnt = 2'b00;
      stall = 1'b0;
    end
  
  endcase
  end
  1'b0: 
  begin
    stall_cnt = 2'b00;
    stall = 1'b0;
  end
endcase
end
*/
//assign stall_d = (((EX_inst[15:11]==5'b10000)|(EX_inst[15:11]==5'b10001))&~stall)? 1'b1:1'b0;
/*
assign stall = 
               (((MEM_inst[15:11]==5'b10000)|(MEM_inst[15:11]==5'b10001))&stall_q)?1'b1:
               (((MEM_inst[15:11]==5'b10000)|(MEM_inst[15:11]==5'b10001))&memStall)?1'b1:
               1'b0;
  */             
    assign stall = ((memwrite|memread) & ~memDone)|(~instMemDone&~instMemDone_q);         
dff stallst (.q(stall_st_q),.d(stall_st_d),.rst(rst),.clk(clk));
//assign stall = memStall|(EX_inst[15:11]==5'b10000)|(EX_inst[15:11]==5'b10001)|(MEM_inst[15:11]==5'b10000)|(MEM_inst[15:11]==5'b10001);
/*
assign stall_ST = ((EX_inst[15:11] == 5'b10000)|(MEM_inst[15:11]==5'b10000)&~memDone); 
assign stall_st_d = stall_st_q? (~memDone):stall_ST;
//assign stall_LD = (EX_inst[15:11]==5'b10001);
assign stall_LD = ((EX_inst[15:11]==5'b10001)&EX_rd_v)&((ID_rs==EX_rd)|(ID_rt==EX_rd));//optimized erroness stall
assign stall = stall_st_d|stall_LD;
//assign stall = ((MEM_inst[15:11]==5'b10001)&MEM_rd_v)&((EX_rs==MEM_rd)|(EX_rt==MEM_rd));

*/
endmodule
