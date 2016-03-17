/* Author: Yunhe Liu & Wenxuan Mao
 * Team: MacroHard
 * Date: 3/13/2016
 * This is the instruction decoder for our processor.
 */
module control(
	//outputs
	RegDst,
	Jump,
	Branch,
	MemRead,
	MemtoReg,
	ALUOp,
	MemWrite,
	ALUSrc,
	RegWrite,
	Rt_Rd,
	Halt,
	ld_imm,
	compareS,
	btr,
	writeR7,
	
	//input
	opcode
);

	output reg RegDst;
	output reg Jump;
	output reg Branch;
	output reg MemRead;
        output reg MemtoReg;
	output reg[4:0] ALUOp;
	output reg MemWrite;
	output reg ALUSrc;
	output reg RegWrite;
	output reg Rt_Rd;
	output reg Halt;
	output reg ld_imm;
	output reg compareS;
	output reg btr;
        output reg writeR7;
	input [4:0] opcode;
	
	//TODO - question: assign here and update in case?
	//how to do case do nothing
	//multiple statement
	always @ *
	begin
		RegDst = 1'b0;
		Jump = 1'b0;
		Branch = 1'b0;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		ALUOp = 5'b00000;
		MemWrite = 1'b0;
		ALUSrc = 1'b0;
		RegWrite = 1'b0;
	        Rt_Rd = 1'b0;
	        Halt = 1'b0;
	        ld_imm = 1'b0;
		compareS = 1'b0;
		btr = 1'b0;
		writeR7 = 1'b0;

		case(opcode)
			5'b00000 : //TODO - HALT_1/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				Halt = 1'b1;
			end

			5'b00001 : //TODO - NOP_2/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end
		
			5'b01000 : //ADDI_3/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b01001 : //SUBI_4/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01001;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end
			
			5'b01010 : //XOR1_5/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01010;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b01011 : //ANDNI_6/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01011;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b10100 : //ROLI_7/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10100;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b10101 : //SLLI_8/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10101;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b10110 : //RORI_9/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10110;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b10111 : //SRLI_10/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10111;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b10000 : //ST_11/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10000;
				MemWrite = 1'b1;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				Rt_Rd = 1'b1;
			end

			5'b10001 : //LD_12/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b1;
				MemtoReg = 1'b1;
				ALUOp = 5'b10001;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				
			end

			5'b10011 : //STU_13/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10011;
				MemWrite = 1'b1;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				Rt_Rd = 1'b1;
			end

			5'b11001 : //BTR_14/38 -TODO
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11001;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				btr = 1'b1;	
			end

			5'b11011 : //ADD,SUB,XOR,ANDN_15-18/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11011;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end

			5'b11010 : //ROL,SLL,ROR,SRL_19-22/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11010;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end

			5'b11100 : //SEQ_23/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11100;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				compareS = 1'b1;
			end

			5'b11101 : //SLT_24/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11101;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				compareS = 1'b1;
			end

			5'b11110 : //SLE_25/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11110;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				compareS = 1'b1;
			end

			5'b11111 : //SCO_26/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11111;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				compareS = 1'b1;
			end

			5'b01100 : //BEQZ_27/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01100;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b01101 : //BNEZ_28/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01101;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b01110 : //BLTZ_29/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01110;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b01111 : //BGEZ_30/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b01111;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b11000 : //LBI_31/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b11000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				ld_imm = 1'b1;
			end

			5'b10010 : //SLBI_32/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b10010;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end

			5'b00100 : //J_33/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b1;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00100;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b00101 : //JR_34/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b1;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00101;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b00110 : //JAL_35/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b1;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00110;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				writeR7 = 1'b1;
			end

			5'b00111 : //JALR_36/38
			begin	
				RegDst = 1'b1;
				Jump = 1'b1;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00111;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				writeR7 = 1'b1;
			end

			5'b00010 : //TODO - siic Rs_37/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end

			5'b00011 : //TODO - NOP/RTI_38/38
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end
		
			default: //TODO
			begin	
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 5'b00000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end
	
		endcase
	end
	
endmodule
