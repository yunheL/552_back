library verilog;
use verilog.vl_types.all;
entity reg_control is
    port(
        rs_v            : out    vl_logic;
        rt_v            : out    vl_logic;
        rd_v            : out    vl_logic;
        r1_reg          : out    vl_logic_vector(2 downto 0);
        r2_reg          : out    vl_logic_vector(2 downto 0);
        r_wr            : out    vl_logic_vector(2 downto 0);
        inst            : in     vl_logic_vector(15 downto 0)
    );
end reg_control;
