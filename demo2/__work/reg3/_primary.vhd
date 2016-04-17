library verilog;
use verilog.vl_types.all;
entity reg3 is
    port(
        read            : out    vl_logic_vector(2 downto 0);
        write           : in     vl_logic_vector(2 downto 0);
        wr_en           : in     vl_logic;
        rst             : in     vl_logic;
        clk             : in     vl_logic
    );
end reg3;
