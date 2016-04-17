library verilog;
use verilog.vl_types.all;
entity harzard is
    port(
        id_rs           : in     vl_logic_vector(2 downto 0);
        id_rt           : in     vl_logic_vector(2 downto 0);
        ex_rd           : in     vl_logic_vector(2 downto 0);
        mem_rd          : in     vl_logic_vector(2 downto 0);
        id_rs_v         : in     vl_logic;
        id_rt_v         : in     vl_logic;
        ex_rd_v         : in     vl_logic;
        mem_rd_v        : in     vl_logic;
        ex_inst         : in     vl_logic_vector(15 downto 0);
        fow_exid_rs     : out    vl_logic;
        fow_exid_rt     : out    vl_logic;
        fow_memid_rs    : out    vl_logic;
        fow_memid_rt    : out    vl_logic;
        stall           : out    vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic
    );
end harzard;
