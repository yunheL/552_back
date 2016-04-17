library verilog;
use verilog.vl_types.all;
entity reg16_init is
    port(
        read            : out    vl_logic_vector(15 downto 0);
        write           : in     vl_logic_vector(15 downto 0);
        wr_en           : in     vl_logic;
        rst             : in     vl_logic;
        clk             : in     vl_logic
    );
end reg16_init;
