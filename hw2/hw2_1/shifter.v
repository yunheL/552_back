module shifter (In, Cnt, Op, Out);
   
   input [15:0] In;
   input [3:0]  Cnt;
   input [1:0]  Op;
   output [15:0] Out;

   /*
   Your code goes here
   */
   reg [15:0] c;
   reg [15:0] d;
   reg [15:0] e;

   reg [15:0] inreg;
   reg [15:0] outreg;
   reg [1:0]  opreg;
   reg [3:0]  cntreg;


   always @ *
   begin
     inreg = In;
     opreg = Op;
     cntreg = Cnt;

    case (Op)
  	  2'b00	:	outreg = inreg;
	  2'b01	:	outreg = inreg; 
          //shift right arthimatic: discard "drop out"
          //on the right and extend sign bit on the left
          2'b10 :
		begin
             		e = cntreg[0] ? {inreg[15],inreg[15:1]}	:	inreg;
             		d = cntreg[1] ? {{2{e[15]}},e[15:2]}	: 	e;
             		c = cntreg[2] ? {{4{d[15]}},d[15:4]} 	: 	d;
             		outreg = cntreg[3] ? {{8{c[15]}},c[15:8]} : 	c;          
		end
	  2'b11	:	outreg = inreg;
	  default:	outreg = inreg;
      endcase
    end

    assign Out = outreg;
endmodule

