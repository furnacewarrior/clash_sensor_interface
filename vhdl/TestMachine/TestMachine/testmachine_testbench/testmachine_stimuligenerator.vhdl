-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.testmachine_testbench_types.all;

entity testmachine_stimuligenerator is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       result : out unsigned(7 downto 0));
end;

architecture structural of testmachine_stimuligenerator is
  signal \#tup_app_arg\               : unsigned(2 downto 0);
  signal s                            : unsigned(2 downto 0);
  signal wild                         : signed(63 downto 0);
  signal \#tup_app_arg_selection_res\ : boolean;
  signal \#vec\                       : testmachine_testbench_types.array_of_unsigned_8(0 to 6);
begin
  \#tup_app_arg_selection_res\ <= s < to_unsigned(6,3);

  \#tup_app_arg\ <= s + to_unsigned(1,3) when \#tup_app_arg_selection_res\ else
                    s;

  \#vec\ <= testmachine_testbench_types.array_of_unsigned_8'( to_unsigned(11,8)
                                                            , to_unsigned(20,8)
                                                            , to_unsigned(30,8)
                                                            , to_unsigned(10,8)
                                                            , to_unsigned(210,8)
                                                            , to_unsigned(21,8)
                                                            , to_unsigned(23,8) );

  -- index begin
  indexvec : block
    signal vec_index : integer range 0 to 7-1;
  begin
    vec_index <= to_integer((wild))
    -- pragma translate_off
                 mod 7
    -- pragma translate_on
                 ;
    result <= \#vec\(vec_index);
  end block;
  -- index end

  -- register begin 
  testmachine_stimuligenerator_register : process(clk,rst)
  begin
    if rst = '1' then
      s <= to_unsigned(0,3)
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

