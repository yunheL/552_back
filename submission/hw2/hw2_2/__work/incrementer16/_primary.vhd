library verilog;
use verilog.vl_types.all;
entity incrementer16 is
    port(
        a               : in     vl_logic_vector(15 downto 0);
        \Out\           : out    vl_logic_vector(15 downto 0)
    );
end incrementer16;
