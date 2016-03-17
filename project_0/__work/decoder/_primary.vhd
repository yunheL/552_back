library verilog;
use verilog.vl_types.all;
entity decoder is
    port(
        inst            : in     vl_logic_vector(15 downto 0);
        rt              : out    vl_logic_vector(2 downto 0);
        rs              : out    vl_logic_vector(2 downto 0);
        rd              : out    vl_logic_vector(2 downto 0);
        imm             : out    vl_logic_vector(15 downto 0);
        displacement    : out    vl_logic_vector(15 downto 0)
    );
end decoder;
