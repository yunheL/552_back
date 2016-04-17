library verilog;
use verilog.vl_types.all;
entity writeback is
    port(
        rd              : in     vl_logic_vector(2 downto 0);
        rs              : in     vl_logic_vector(2 downto 0);
        regdst          : in     vl_logic;
        memtoreg        : in     vl_logic;
        slbi            : in     vl_logic;
        compares        : in     vl_logic;
        btr_cntl        : in     vl_logic;
        aluout          : in     vl_logic_vector(15 downto 0);
        mem_out         : in     vl_logic_vector(15 downto 0);
        alu_out         : in     vl_logic_vector(15 downto 0);
        imm             : in     vl_logic_vector(15 downto 0);
        writereg        : out    vl_logic_vector(2 downto 0);
        ofl             : in     vl_logic;
        zero            : in     vl_logic;
        n               : in     vl_logic;
        p               : in     vl_logic;
        inst            : in     vl_logic_vector(15 downto 0);
        ld_imm          : in     vl_logic;
        regwritedata    : out    vl_logic_vector(15 downto 0)
    );
end writeback;
