library verilog;
use verilog.vl_types.all;
entity incrementer4 is
    port(
        a               : in     vl_logic_vector(3 downto 0);
        \Out\           : out    vl_logic_vector(3 downto 0);
        cin             : in     vl_logic;
        cout            : out    vl_logic;
        p               : out    vl_logic
    );
end incrementer4;
