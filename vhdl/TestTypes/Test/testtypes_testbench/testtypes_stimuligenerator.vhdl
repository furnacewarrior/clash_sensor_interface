-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.testtypes_testbench_types.all;

entity testtypes_stimuligenerator is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       result : out std_logic_vector(7 downto 0));
end;

architecture structural of testtypes_stimuligenerator is
  signal \#tup_app_arg\               : unsigned(3 downto 0);
  signal s                            : unsigned(3 downto 0);
  signal wild                         : signed(63 downto 0);
  signal \#tup_app_arg_selection_res\ : boolean;
  signal \#vec\                       : testtypes_testbench_types.array_of_std_logic_vector_8(0 to 10);
begin
  \#tup_app_arg_selection_res\ <= s < to_unsigned(10,4);

  \#tup_app_arg\ <= s + to_unsigned(1,4) when \#tup_app_arg_selection_res\ else
                    s;

  \#vec\ <= testtypes_testbench_types.array_of_std_logic_vector_8'( std_logic_vector'(x"0B")
                                                                  , std_logic_vector'(x"0A")
                                                                  , std_logic_vector'(x"09")
                                                                  , std_logic_vector'(x"08")
                                                                  , std_logic_vector'(x"07")
                                                                  , std_logic_vector'(x"06")
                                                                  , std_logic_vector'(x"05")
                                                                  , std_logic_vector'(x"04")
                                                                  , std_logic_vector'(x"03")
                                                                  , std_logic_vector'(x"02")
                                                                  , std_logic_vector'(x"01") );

  -- index begin
  indexvec : block
    signal vec_index : integer range 0 to 11-1;
  begin
    vec_index <= to_integer((wild))
    -- pragma translate_off
                 mod 11
    -- pragma translate_on
                 ;
    result <= \#vec\(vec_index);
  end block;
  -- index end

  -- register begin 
  testtypes_stimuligenerator_register : process(clk,rst)
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

