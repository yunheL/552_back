library verilog;
use verilog.vl_types.all;
entity ex_control is
    port(
        aluop           : out    vl_logic_vector(4 downto 0);
        alusrc          : out    vl_logic;
        opcode          : in     vl_logic_vector(4 downto 0)
    );
end ex_control;
