module alu_control(
	//output
	alu_op,

  //input
	opcode,
  func
)

  output[2:0] alu_op;
  
  input [4:0] opcode;
  input [1:0] func;

  always @ *
  begin
		
		alu_op = 3'b000;
    
    case(opcode)
			5'b01000 : alu_op = 3'b100; //ADDI
      5'b01001 : alu_op = 3'b100; //SUBI
      5'b01010 : alu_op = 3'b110; //XORI

    endcase
  end
endmodule
