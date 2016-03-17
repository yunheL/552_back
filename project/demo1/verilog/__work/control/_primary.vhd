library verilog;
use verilog.vl_types.all;
entity control is
    port(
        regdst          : out    vl_logic;
        jump            : out    vl_logic;
        branch          : out    vl_logic;
        memread         : out    vl_logic;
        memtoreg        : out    vl_logic;
        aluop           : out    vl_logic_vector(4 downto 0);
        memwrite        : out    vl_logic;
        alusrc          : out    vl_logic;
        regwrite        : out    vl_logic;
        rt_rd           : out    vl_logic;
        halt            : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0)
    );
end control;
