library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        a               : in     vl_logic_vector(15 downto 0);
        b               : in     vl_logic_vector(15 downto 0);
        cin             : in     vl_logic;
        op              : in     vl_logic_vector(2 downto 0);
        inva            : in     vl_logic;
        invb            : in     vl_logic;
        sign            : in     vl_logic;
        \Out\           : out    vl_logic_vector(15 downto 0);
        ofl             : out    vl_logic;
        z               : out    vl_logic;
        n               : out    vl_logic;
        p               : out    vl_logic
    );
end alu;
