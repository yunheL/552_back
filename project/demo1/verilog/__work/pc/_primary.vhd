library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        en              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        jump            : in     vl_logic;
        inst            : in     vl_logic_vector(15 downto 0);
        addr            : out    vl_logic_vector(15 downto 0);
        zero            : in     vl_logic;
        branch          : in     vl_logic;
        rs              : in     vl_logic_vector(15 downto 0)
    );
end pc;
