/* $Author: karu $ */
/* $LastChangedDate: 2009-04-24 09:28:13 -0500 (Fri, 24 Apr 2009) $ */
/* $Rev: 77 $ */

module mem_system(/*AUTOARG*/
   // Outputs
   DataOut, Done, Stall, CacheHit, err,
   // Inputs
   Addr, DataIn, Rd, Wr, createdump, clk, rst
   );
   
   input [15:0] Addr;
   input [15:0] DataIn;
   input        Rd;
   input        Wr;
   input        createdump;
   input        clk;
   input        rst;
   
   output reg [15:0] DataOut;
   output reg Done;
   output reg Stall;
   output reg CacheHit;
   output err;




 // your code here
  wire hit,dirty0,dirty1;
  reg comp, c_en, c_validin;
  wire hit0,hit1,valid0,valid1;
  reg  write0, write1;
  wire c0_active,c1_active;
  reg c0_d_active, c1_d_active; 
  
  reg[4:0] tag_out;
  wire [4:0]  tag_out0, tag_out1;
  reg [4:0] tag_in;
  reg [7:0] index;
  reg [2:0] offset;
  wire [15:0] cache_dataout0, cache_dataout1, mem_dataout;
  reg [15:0] cache_datain,mem_datain;
  
  reg mem_rd, mem_wr;
  reg [15:0] mem_addr;
  wire [3:0] mem_busy;
  
  wire [15:0] state;
  reg [15:0] nstate;
  
  wire victim;
  reg victim_d;
  reg16 statereg (.read(state),.write(nstate),.wr_en(1'b1),.rst(rst),.clk(clk));
  dff c0_ac (.q(c0_active), .d(c0_d_active), .clk(clk), .rst(rst));
  dff c1_ac (.q(c1_active), .d(c1_d_active), .clk(clk), .rst(rst));

  dff victimway(.q(victim), .d(victim_d), .clk(clk), .rst(rst));


   
   
   
   
   
   
   
   
   
   
      /* data_mem = 1, inst_mem = 0 *
    * needed for cache parameter */
   parameter mem_type = 0;
   //cache (0 + memtype) c0(// Outputs
   cache c0(
                          .tag_out              (tag_out0),
                          .data_out             (cache_dataout0),
                          .hit                  (hit0),
                          .dirty                (dirty0),
                          .valid                (valid0),
                          .err                  (),
                          // Inputs
                          .enable               (c_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (tag_in),
                          .index                (index),
                          .offset               (offset),
                          .data_in              (cache_datain),
                          .comp                 (comp),
                          .write                (write0),
                          .valid_in             (c_validin));
   //cache (2 + memtype) c1(// Outputs
   cache c1(
                          .tag_out              (tag_out1),
                          .data_out             (cache_dataout1),
                          .hit                  (hit1),
                          .dirty                (dirty1),
                          .valid                (valid1),
                          .err                  (),
                          // Inputs
                          .enable               (c_en),
                          .clk                  (clk),
                          .rst                  (rst),
                          .createdump           (createdump),
                          .tag_in               (tag_in),
                          .index                (index),
                          .offset               (offset),
                          .data_in              (cache_datain),
                          .comp                 (comp),
                          .write                (write1),
                          .valid_in             (c_validin));

   four_bank_mem mem(// Outputs
                     .data_out          (mem_dataout),
                     .stall             (),
                     .busy              (mem_busy),
                     .err               (),
                     // Inputs
                     .clk               (clk),
                     .rst               (rst),
                     .createdump        (createdump),
                     .addr              (mem_addr),
                     .data_in           (mem_datain),
                     .wr                (mem_wr),
                     .rd                (mem_rd));
  
  assign hit = hit0|hit1;
  
  
  always @ * begin
  //default outputs
    mem_rd = 1'b0;
    mem_wr = 1'b0;
    mem_addr  =16'h0000;
    
    Stall = 1'b1;
    Done = 1'b0;
    c_en = 1'b1;
    nstate = 16'h0000;
    comp = 1'b1;
    tag_in = 5'h00;
    tag_out = 5'h00;
    index = 8'h00;
    offset = 3'h0;
    cache_datain = 16'h0000;
    CacheHit = 1'b0;
    write0 = 1'b0;
    write1 = 1'b0;
    DataOut = 16'h0000;
    mem_datain = 16'h0000;


    case (state)
      16'h0000:				//IDLE
      begin
        c0_d_active = 1'b0;
        c1_d_active = 1'b0;
        c_en = (Wr|Rd)? 1'b1:1'b0;
        nstate = (Wr|Rd)? 16'h0001:16'h0000;
        comp = 1'b1;
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];
        cache_datain = DataIn;
        c_validin = 1'b0;
        Stall = 1'b0;
        
      end
      
      16'h0001:				// Rd/Wr Comp cycle
      begin
        nstate = (hit&&Rd)? 16'h0002:
        	 (hit&&Wr)? 16'h0003:
        		    16'h0004;		//miss
        	    
        c_en = 1'b1;
        comp = 1'b1;
        //write0 = Wr&c0_active;
        //write1 = Wr&c1_active;
        cache_datain = DataIn;
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];
        write0 = Wr&hit0;
        write1 = (hit0&hit1)? 1'b0:Wr&hit1;
        c_validin = 1'b0;
      end
      
      16'h0002:				//Rd Hit
      begin
        c_en = 1'b1;
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];
        DataOut = (hit0&valid0)? cache_dataout0:
                  (hit1&valid1)? cache_dataout1:16'h0000;
        Done = ((hit0&valid0)|(hit1&valid1));
        nstate = ((hit0&valid0)|(hit1&valid1))? 16'h0000:16'h0005;	//go to not valid miss state if not valid
        CacheHit = (valid0|valid1);
        c0_d_active = (~valid0&~valid1)?1'b1:
                     (~valid0&valid1)? 1'b1:
                     (valid0&valid1&~victim)?1'b1:1'b0; 
                     
        c1_d_active = (~valid0&~valid1)?1'b0:
                     (valid0&~valid1)? 1'b1:
                     (valid0&valid1&victim)?1'b1:1'b0;
        //Stall = (valid0|valid1)?1'b0:1'b1;
      end
      
      16'h0003:				//Wr Hit
      begin
        nstate = ((hit0&valid0)|(hit1&valid1))? 16'h0000:16'h0005;	//if not valid (miss) go to load from mem
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];
        Done = (valid0|valid1);
        CacheHit = (valid0|valid1);
        
        c0_d_active = (~valid0&~valid1)?1'b1:
                     (~valid0&valid1)? 1'b1:
                     (valid0&valid1&~victim)?1'b1:1'b0; 
                     
        c1_d_active = (~valid0&~valid1)?1'b0:
                     (valid0&~valid1)? 1'b1:
                     (valid0&valid1&victim)?1'b1:1'b0;
        //Stall = (valid0|valid1)?1'b0:1'b1;
      end
      
      16'h0004:				// Miss
      begin
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];

        c0_d_active = (~valid0&~valid1)?1'b1:
                     (~valid0&valid1)? 1'b1:
                     (valid0&valid1&~victim)?1'b1:1'b0; 
                     
        c1_d_active = (~valid0&~valid1)?1'b0:
                     (valid0&~valid1)? 1'b1:
                     (valid0&valid1&victim)?1'b1:1'b0;
        write0 = 1'b0;
        write1 = 1'b0;
        nstate = ((c0_d_active&dirty0)|(c1_d_active&dirty1))?16'h000c:16'h0005;  //writeback or load from mem

      end
      
      16'h0005:				//load mem0
      begin
        mem_rd = 1'b1;
        mem_addr = {Addr[15:3],{3{1'b0}}};
        nstate = 16'h0006;
      end
      
      16'h0006:				//load mem1
      begin
        mem_rd = 1'b1;
        mem_addr = {{Addr[15:3]},{1'b0},{1'b1},{1'b0}};
        nstate = 16'h0007;
      end
      
      16'h0007:				//load mem2 0 in cache
      begin
        mem_rd = 1'b1;
        mem_addr = {{Addr[15:3]},{1'b1},{1'b0},{1'b0}};
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b000;
        comp = 1'b0;
        write0 = c0_active;
        write1 = c1_active;

        c_validin = 1'b1;
        cache_datain = mem_dataout;
        nstate = 16'h0008;
      end
      
      16'h0008:				//load mem3 1 in cache
      begin
        mem_rd = 1'b1;
        mem_addr = {{Addr[15:3]},{1'b1},{1'b1},{1'b0}};
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b010;
        comp = 1'b0;
        write0 = c0_active;
        write1 = c1_active;
        c_validin = 1'b1;
        cache_datain = mem_dataout;
        nstate = 16'h0009;
      end
      
      
      16'h0009:				//2 in cache
      begin
        mem_rd = 1'b1;
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b100;
        comp = 1'b0;
        write0 = c0_active;
        write1 = c1_active;
        c_validin = 1'b1;
        cache_datain = mem_dataout;
        nstate = 16'h000a;
      end
      
      16'h000a:				//3 in cache
      begin
        mem_rd = 1'b1;
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b110;
        comp = 1'b0;
        write0 = c0_active;
        write1 = c1_active;
        c_validin = 1'b1;
        cache_datain = mem_dataout;
        nstate = 16'h000b;
      end
      
      16'h000b:				//perform rd or wr
      begin
        mem_rd = 1'b1;
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];
        comp = 1'b1;
        write0 = Wr&c0_active;
        write1 = Wr&c1_active;
        cache_datain = 	DataIn;
        nstate = (Wr&~Rd)?16'h0012:
                 (~Wr&Rd)?16'h0011:
                 16'h0000;
      end
      
      16'h000c:				//write back 0
      begin
        mem_wr = 1'b1;
        tag_out = (c0_active)? tag_out0:
                  (c1_active)? tag_out1:
                  5'h00;
        mem_addr = {{tag_out},{Addr[10:3]},{1'b0},{1'b0},{1'b0}};
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b000;
        comp = 1'b0;
        //write0 = Wr&c0_active;
        //write1 = Wr&c1_active;
        //c_validin = 1'b1;
        mem_datain = (c0_active)?cache_dataout0:
                     (c1_active)?cache_dataout1:
                     16'h0000;
        nstate = 16'h000d;
      end
      
      16'h000d:				//write back 1
      begin
        mem_wr = 1'b1;
        tag_out = (c0_active)? tag_out0:
                  (c1_active)? tag_out1:
                  5'h00;
        mem_addr = {{tag_out},{Addr[10:3]},{1'b0},{1'b1},{1'b0}};
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b010;
        comp = 1'b0;
        //write0 = Wr&c0_active;
        //write1 = Wr&c1_active;
        //c_validin = 1'b1;
        mem_datain = (c0_active)?cache_dataout0:
                     (c1_active)?cache_dataout1:
                     16'h0000;
        nstate = 16'h000e;
      end
      
      16'h000e:				//write back 2
      begin
        mem_wr = 1'b1;
        tag_out = (c0_active)? tag_out0:
                  (c1_active)? tag_out1:
                  5'h00;
        mem_addr = {{tag_out},{Addr[10:3]},{1'b1},{1'b0},{1'b0}};
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b100;
        comp = 1'b0;
        //write0 = Wr&c0_active;
        //write1 = Wr&c1_active;
        //c_validin = 1'b1;
        mem_datain = (c0_active)?cache_dataout0:
                     (c1_active)?cache_dataout1:
                     16'h0000;
        nstate = 16'h000f;
      end
      
      16'h000f:				//write back 3
      begin
        mem_wr = 1'b1;
        tag_out = (c0_active)? tag_out0:
                  (c1_active)?tag_out1:
                  5'h00;
        mem_addr = {{tag_out},{Addr[10:3]},{1'b1},{1'b1},{1'b0}};
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = 3'b110;
        comp = 1'b0;
        //write0 = Wr&c0_active;
        //write1 = Wr&c1_active;
        //c_validin = 1'b1;
        mem_datain = (c0_active)?cache_dataout0:
                     (c1_active)?cache_dataout1:
                     16'h0000;
        nstate = 16'h0005;
      end
      /*
      16'h0010:				//busy wait write
      begin
     
        //stay at curr state to wait for mem to complete writing
        //go to load mem when finished
        nstate = (mem_busy[0]|mem_busy[1]|mem_busy[2]|mem_busy[3])?16'h0010:16'h0005;
      end
      */
      16'h0011:				//Loaded Rd Miss 
      begin
        
        tag_in = Addr[15:11];
        index = Addr[10:3];;
        offset = Addr[2:0];
        DataOut = (c0_active)? cache_dataout0:
                  (c1_active)? cache_dataout1:16'h0000;
        Done = (valid0|valid1);
        nstate =  16'h0000;	//go to not valid miss state if not valid
        CacheHit = 1'b0;
        //Stall = 1'b0;
      end
      
      16'h0012:				//Loaded Wr Miss
      begin
        nstate =  16'h0000;	//if not valid (miss) go to load from mem
        tag_in = Addr[15:11];
        index = Addr[10:3];
        offset = Addr[2:0];
        //Stall = 1'b0;
        //write0 = Wr&c0_active;
        //write1 = Wr&c1_active;
        Done = (valid0|valid1);
        CacheHit = 1'b0;
        DataOut = (c0_active)? cache_dataout0:
                  (c1_active)? cache_dataout1:16'h0000;
      end
      
      default:
        nstate = 16'h0000;
      endcase
        
 end       
 
 always @ (Rd or Wr or rst) begin
   victim_d = (Rd|Wr)? (~victim):
              (rst)? 1'b0:victim;
              end
                
        
        
    
    
  
   
endmodule // mem_system

// DUMMY LINE FOR REV CONTROL :9:
