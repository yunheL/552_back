library verilog;
use verilog.vl_types.all;
entity if_control is
    port(
        jump            : out    vl_logic;
        branch          : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0)
    );
end if_control;
