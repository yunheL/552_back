library verilog;
use verilog.vl_types.all;
entity wb_control is
    port(
        memtoreg        : out    vl_logic;
        regwrite        : out    vl_logic;
        ld_imm          : out    vl_logic;
        compares        : out    vl_logic;
        btr             : out    vl_logic;
        writer7         : out    vl_logic;
        regdst          : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0)
    );
end wb_control;
