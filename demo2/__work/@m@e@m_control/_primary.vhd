library verilog;
use verilog.vl_types.all;
entity mem_control is
    port(
        memread         : out    vl_logic;
        memwrite        : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0)
    );
end mem_control;
