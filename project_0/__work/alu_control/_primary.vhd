library verilog;
use verilog.vl_types.all;
entity alu_control is
    port(
        alu_op          : out    vl_logic_vector(2 downto 0);
        inv_a           : out    vl_logic;
        inv_b           : out    vl_logic;
        cin             : out    vl_logic;
        shamt           : out    vl_logic_vector(3 downto 0);
        flip_1          : out    vl_logic;
        flip_2          : out    vl_logic;
        shift           : out    vl_logic;
        slbi            : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0);
        func            : in     vl_logic_vector(1 downto 0);
        immd            : in     vl_logic_vector(3 downto 0)
    );
end alu_control;
