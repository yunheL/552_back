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
   wire [15:0] nxt_pc;
   //control
   wire regdst;
   wire branch,jump,memread,memwrite,memtoreg,alusrc,regwrite;
   wire ld_imm, btr_cntl, wr_r7; 
   //alu control
   wire [4:0] opcode;
   wire [2:0] aluop;
   wire invA,invB,cin,flip1,flip2, sh_select;
   wire [3:0] shamt;
   wire shift,halt;
   wire slbi;
   //decoder
   wire [2:0] rs,rt,rd;
   wire [15:0] imm, displacement;
   
   //regfile inputs and ALU operands
   wire [2:0] writereg, read2sel;
   wire [15:0] read1data,read2data, opB, aluOut;
   wire ofl,zero,rt_rd,N,P; 
   wire c_out;

   wire [15:0] mem_out;
   wire [15:0] regwrback,regwritedata;
   wire [15:0] slbi_aluOut;
   
   //seq/slt/sle/sco
   wire compareS;
   wire [15:0] sResults, btr_out;
   
   assign btr_out = {aluOut[0],aluOut[1],aluOut[2],aluOut[3],
                     aluOut[4],aluOut[5],aluOut[6],aluOut[7],
                    aluOut[8],aluOut[9],aluOut[10],aluOut[11],
                    aluOut[12],aluOut[13],aluOut[14],aluOut[15]};
   
  assign sResults = (inst[15:11]==5'b11100) ? zero :
                    (inst[15:11]==5'b11101) ? (ofl ? (aluOut[15]) : ((!aluOut[15]) & (!zero))) :
                    (inst[15:11]==5'b11110) ? (ofl ? (aluOut[15]) : (!aluOut[15])) :
                    (inst[15:11]==5'b11111) ? c_out :
		    16'h0000;

/* 
   assign sResults =  (zero&(inst[15:11]==5'b11100))? 16'h0001:
                   (P&(inst[15:11]==5'b11101))? 16'h0001:
                   ((P|zero)&(inst[15:11]==5'b11110))? 16'h0001:
                   (c_out&(inst[15:11]==5'b11111))? 16'h0001:
                   16'h0000;
*/
   
   assign pc_en=1'b1;//TODO change when no-op
   
   assign writereg = (regdst)? rd:rs;
   assign read2sel = (rt_rd)?rd:rt;
   assign opB = (alusrc)? read2data:
                (shift) ? {{12{1'b0}},shamt}:
                imm; 
  assign slbi_aluOut = {(aluOut[15]|imm[15]), (aluOut[14]|imm[14]),
  			(aluOut[13]|imm[13]), (aluOut[12]|imm[12]),
  			(aluOut[11]|imm[11]), (aluOut[10]|imm[10]),
  			(aluOut[9]|imm[9]), (aluOut[8]|imm[8]),
  			(aluOut[7]|imm[7]), (aluOut[6]|imm[6]),
  			(aluOut[5]|imm[5]), (aluOut[4]|imm[4]),
  			(aluOut[3]|imm[3]), (aluOut[2]|imm[2]),
  			(aluOut[1]|imm[1]), (aluOut[0]|imm[0])};
  			
  assign regwrback = (memtoreg)?mem_out:
                     (slbi)?slbi_aluOut:
                     (compareS)? sResults:
                     btr_cntl? btr_out:
		     (wr_r7) ? nxt_pc:
                      aluOut;
  assign opcode = inst[15:11];
  assign regwritedata = (ld_imm)? imm:regwrback;  
  
   pc prog_c (.en(pc_en),.clk(clk),.rst(rst),.jump(jump),.inst(inst),.addr(addr),.branch(branch),.rs(read1data),.pc_nx(nxt_pc));
   
   memory2c inst_mem (.data_out(inst), .data_in(16'h0000), .addr(addr), .enable(1'b1), .wr(1'b0), .createdump(), .clk(clk), .rst(rst));
   
   rf regfile (.read1data(read1data), .read2data(read2data), .err(err), .clk(clk), .rst(rst), .read1regsel(rs), .read2regsel(read2sel), .writeregsel(writereg), .writedata(regwritedata), .write(regwrite));
   
   alu ALU(.A(read1data), .B(opB), .Cin(cin), .Op(aluop), .invA(invA), .invB(invB), .sign(1'b1), .Out(aluOut), .Ofl(ofl), .Z(zero),.N(N),.P(P), .c_out(c_out));
   
   decoder inst_decode(.inst(inst),.rt(rt),.rs(rs),.rd(rd),.imm(imm),.displacement(displacement));
   
   memory2c data_mem(.data_out(mem_out), .data_in(read2data), .addr(aluOut), .enable(memread|memwrite), .wr(memwrite), .createdump(1'b0), .clk(clk), .rst(rst));
   
   control cntl(.RegDst(regdst),.Jump(jump),.Branch(branch),.MemRead(memread),.MemtoReg(memtoreg),.ALUOp(),.MemWrite(memwrite),.ALUSrc(alusrc),.RegWrite(regwrite),.opcode(opcode),.Rt_Rd(rt_rd),.Halt(halt),.ld_imm(ld_imm),.compareS(compareS),.btr(btr_cntl),.writeR7(wr_r7));

   alu_control a_c(
  //output
  .alu_op(aluop),
  .inv_a(invA),
  .inv_b(invB),
  .cin(cin),
  .shamt(shamt),
  .flip_1(flip1),
  .flip_2(flip2),
  .shift(shift),
  .SLBI(slbi),
  //input
  .opcode(opcode),
  .func(inst[1:0]),
  .immd(inst[3:0])
);
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
