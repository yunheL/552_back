library verilog;
use verilog.vl_types.all;
entity id_control is
    port(
        rt_rd           : out    vl_logic;
        halt            : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0)
    );
end id_control;
