-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity lightsensor_spictrl is
  port(-- clock
       eta   : in std_logic;
       -- asynchronous reset: active high
       eta_0 : in std_logic;
       eta_1 : in lightsensor_types.tup2_1;
       y     : out lightsensor_types.tup2_2);
end;

architecture structural of lightsensor_spictrl is
  signal result                          : lightsensor_types.tup7;
  signal \#tup_case_alt\                 : lightsensor_types.tup7;
  signal \#tup_case_alt_0\               : lightsensor_types.tup7;
  signal \#$sshiftBitInOutOut\           : lightsensor_types.tup2_3;
  signal ds4                             : std_logic;
  signal \#$sshiftBitInOutOut_app_arg\   : std_logic_vector(7 downto 0);
  signal \#tup_app_arg\                  : std_logic_vector(7 downto 0);
  signal ds3                             : std_logic;
  signal \input'\                        : lightsensor_types.connstd;
  signal \buffer\                        : std_logic_vector(7 downto 0);
  signal mosi                            : std_logic;
  signal counter                         : unsigned(2 downto 0);
  signal cs                              : std_logic;
  signal \dataOut\                       : std_logic_vector(7 downto 0);
  signal \nextOutput\                    : std_logic;
  signal \clkOut\                        : std_logic;
  signal \busyOut\                       : std_logic;
  signal ds2                             : std_logic_vector(7 downto 0);
  signal miso1                           : std_logic;
  signal ds1                             : lightsensor_types.tup2_3;
  signal eta_2                           : lightsensor_types.tup7;
  signal \#tup_case_alt_selection_res\   : boolean;
  signal \#tup_case_alt_0_selection_res\ : boolean;
begin
  y <= ( tup2_2_sel0 => ( tup3_0_sel0 => \clkOut\
       , tup3_0_sel1 => cs
       , tup3_0_sel2 => mosi )
       , tup2_2_sel1 => ( connstd_sel0 => \dataOut\
       , connstd_sel1 => \nextOutput\
       , connstd_sel2 => \busyOut\ ) );

  with (counter) select
    result <= \#tup_case_alt\ when "111",
              ( tup7_sel0 => counter + to_unsigned(1,3)
              , tup7_sel1 => \#$sshiftBitInOutOut\
              , tup7_sel2 => '0'
              , tup7_sel3 => \dataOut\
              , tup7_sel4 => '0'
              , tup7_sel5 => '1'
              , tup7_sel6 => '1' ) when others;

  \#tup_case_alt_selection_res\ <= ds4 = ('0');

  \#tup_case_alt\ <= \#tup_case_alt_0\ when \#tup_case_alt_selection_res\ else
                     ( tup7_sel0 => to_unsigned(7,3)
                     , tup7_sel1 => ( tup2_3_sel0 => \buffer\
                     , tup2_3_sel1 => mosi )
                     , tup7_sel2 => '0'
                     , tup7_sel3 => \dataOut\
                     , tup7_sel4 => '0'
                     , tup7_sel5 => '0'
                     , tup7_sel6 => '1' );

  \#tup_case_alt_0_selection_res\ <= ds3 = ('0');

  \#tup_case_alt_0\ <= ( tup7_sel0 => to_unsigned(0,3)
                       , tup7_sel1 => \#$sshiftBitInOutOut\
                       , tup7_sel2 => '0'
                       , tup7_sel3 => \#tup_app_arg\
                       , tup7_sel4 => '1'
                       , tup7_sel5 => '1'
                       , tup7_sel6 => '1' ) when \#tup_case_alt_0_selection_res\ else
                       ( tup7_sel0 => to_unsigned(7,3)
                       , tup7_sel1 => ( tup2_3_sel0 => \buffer\
                       , tup2_3_sel1 => mosi )
                       , tup7_sel2 => '1'
                       , tup7_sel3 => \#tup_app_arg\
                       , tup7_sel4 => '1'
                       , tup7_sel5 => '0'
                       , tup7_sel6 => '0' );

  lightsensor_shiftbitinout_sshiftbitinoutout : entity lightsensor_shiftbitinout
    port map
      ( result => \#$sshiftBitInOutOut\
      , eta    => \#$sshiftBitInOutOut_app_arg\
      , eta1   => miso1 );

  ds4 <= \input'\.connstd_sel2;

  with (counter) select
    \#$sshiftBitInOutOut_app_arg\ <= ds2 when "111",
                                     \buffer\ when others;

  -- replaceBit begin
  replacebit : block
    signal vec_index : integer range 0 to 8-1;
  begin
    vec_index <= to_integer(to_signed(0,64))
    -- pragma translate_off
                 mod 8
    -- pragma translate_on
                 ;

    process(vec_index,miso1)
      variable ivec : std_logic_vector(7 downto 0);
    begin
      ivec := (std_logic_vector(shift_left(unsigned(\buffer\),to_integer(to_signed(1,64)))));
      ivec(vec_index) := miso1;
      \#tup_app_arg\ <= ivec;
    end process;
  end block;
  -- replaceBit end

  ds3 <= \input'\.connstd_sel1;

  \input'\ <= eta_1.tup2_1_sel0;

  \buffer\ <= ds1.tup2_3_sel0;

  mosi <= ds1.tup2_3_sel1;

  counter <= eta_2.tup7_sel0;

  cs <= eta_2.tup7_sel2;

  \dataOut\ <= eta_2.tup7_sel3;

  \nextOutput\ <= eta_2.tup7_sel4;

  \clkOut\ <= eta_2.tup7_sel5;

  \busyOut\ <= eta_2.tup7_sel6;

  ds2 <= \input'\.connstd_sel0;

  miso1 <= eta_1.tup2_1_sel1;

  ds1 <= eta_2.tup7_sel1;

  -- register begin 
  lightsensor_spictrl_register : process(eta,eta_0)
  begin
    if eta_0 = '1' then
      eta_2 <= ( tup7_sel0 => to_unsigned(7,3), tup7_sel1 => ( tup2_3_sel0 => std_logic_vector'(x"00"), tup2_3_sel1 => '1' ), tup7_sel2 => '0', tup7_sel3 => std_logic_vector'(x"00"), tup7_sel4 => '0', tup7_sel5 => '0', tup7_sel6 => '0' )
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(eta) then
      eta_2 <= result
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end
end;

