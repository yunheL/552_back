/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As desribed in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   
   //PC & fetch
   //Decode
   //Reg
   //ALU
   //ALU control
   //MEM
   //Control
   //JUMP Branch (ALU)
   
   
   //pc
   wire [15:0] inst, addr;
   wire pc_en;
   //control
   wire regdst;
   wire branch,jump,memread,memwrite,memtoreg,alusrc,regwrite; 
   //alu control
   wire [4:0] opcode;
   wire [2:0] aluop;
   wire invA,invB,cin,flip1,flip2, sh_select;
   wire [3:0] shamt;
   wire shift,halt;
   
   //decoder
   wire [2:0] rs,rt,rd;
   wire [15:0] imm, displacement;
   
   //regfile inputs and ALU operands
   wire [2:0] writereg, read2sel;
   wire [15:0] read1data,read2data, opB, aluOut;
   wire ofl,zero,rt_rd;
   
   wire [15:0] mem_out;
   wire [15:0] regwrback;
   
   assign pc_en=1'b1;//TODO change when no-op
   
   assign writereg = (regdst)? rd:rs;
   assign read2sel = (rt_rd)?rd:rt;
   assign opB = (alusrc)? read2data:
                (shift) ? {{12{1'b0}},shamt}:
                imm; 
  assign regwrback = (memtoreg)?mem_out:aluOut;
  assign opcode = inst[15:11];
   pc prog_c (.en(pc_en),.clk(clk),.rst(rst),.jump(jump),.inst(inst),.addr(addr),.zero(),.branch(branch),.rs(read1data));
   
   memory2c inst_mem (.data_out(inst), .data_in(16'h0000), .addr(addr), .enable(1'b1), .wr(1'b0), .createdump(), .clk(clk), .rst(rst));
   
   rf regfile (.read1data(read1data), .read2data(read2data), .err(err), .clk(clk), .rst(rst), .read1regsel(rs), .read2regsel(read2sel), .writeregsel(writereg), .writedata(regwrback), .write(regwrite));
   
   alu ALU(.A(read1data), .B(opB), .Cin(cin), .Op(aluop), .invA(invA), .invB(invB), .sign(1'b1), .Out(aluOut), .Ofl(ofl), .Z(zero));
   
   decoder inst_decode(.inst(inst),.rt(rt),.rs(rs),.rd(rd),.imm(imm),.displacement(displacement));
   
   memory2c data_mem(.data_out(mem_out), .data_in(read2data), .addr(aluOut), .enable(memread|memwrite), .wr(memwrite), .createdump(), .clk(clk), .rst(rst));
   
   control cntl(.RegDst(regdst),.Jump(jump),.Branch(branch),.MemRead(memread),.MemtoReg(memtoreg),.ALUOp(),.MemWrite(memwrite),.ALUSrc(alusrc),.RegWrite(regwrite),.opcode(opcode),.Rt_Rd(rt_rd),.Halt(halt));

   alu_control a_c(
  //output
  .alu_op(aluop),
  .inv_a(invA),
  .inv_b(invB),
  .cin(cin),
  .shamt(shamt),
  .flip_1(flip1),
  .flip_2(flip2),
  .shift(shift_sel),

  //input
  .opcode(opcode),
  .func(inst[1:0]),
  .immd(inst[3:0])
);
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
