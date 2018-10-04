-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.spi_ctrl_testbench_types.all;

entity spi_ctrl_stimuligenerator is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       result : out spi_ctrl_testbench_types.tup3);
end;

architecture structural of spi_ctrl_stimuligenerator is
  signal \#tup_app_arg\               : unsigned(3 downto 0);
  signal s                            : unsigned(3 downto 0);
  signal wild                         : signed(63 downto 0);
  signal \#tup_app_arg_selection_res\ : boolean;
  signal \#vec\                       : spi_ctrl_testbench_types.array_of_tup3(0 to 13);
begin
  \#tup_app_arg_selection_res\ <= s < to_unsigned(13,4);

  \#tup_app_arg\ <= s + to_unsigned(1,4) when \#tup_app_arg_selection_res\ else
                    s;

  \#vec\ <= spi_ctrl_testbench_types.array_of_tup3'( ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '0' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '0'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '0' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '0' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '0' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '0' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '0'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '0'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '0'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '0'
                                                   , tup3_sel2 => '0' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '0'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '1' )
                                                   , ( tup3_sel0 => std_logic_vector'(x"0B")
                                                   , tup3_sel1 => '1'
                                                   , tup3_sel2 => '1' ) );

  -- index begin
  indexvec : block
    signal vec_index : integer range 0 to 14-1;
  begin
    vec_index <= to_integer((wild))
    -- pragma translate_off
                 mod 14
    -- pragma translate_on
                 ;
    result <= \#vec\(vec_index);
  end block;
  -- index end

  -- register begin 
  spi_ctrl_stimuligenerator_register : process(clk,rst)
  begin
    if rst = '1' then
      s <= to_unsigned(0,4)
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      s <= \#tup_app_arg\
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  wild <= (signed(std_logic_vector(resize(s,64))));
end;

