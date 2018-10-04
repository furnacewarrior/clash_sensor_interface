-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.spi_ctrl_types.all;

entity spi_ctrl_spictrl_sspictrl is
  port(-- clock
       clk    : in std_logic;
       -- asynchronous reset: active high
       rst    : in std_logic;
       input  : in spi_ctrl_types.tup2;
       result : out spi_ctrl_types.tup2_0);
end;

architecture structural of spi_ctrl_spictrl_sspictrl is
  signal mosi                             : std_logic;
  signal counter                          : unsigned(2 downto 0);
  signal cs                               : std_logic;
  signal \dataOut\                        : std_logic_vector(7 downto 0);
  signal \nextOutput\                     : std_logic;
  signal \clkOut\                         : std_logic;
  signal \busyOut\                        : std_logic;
  signal \stateL\                         : unsigned(2 downto 0);
  signal ds1                              : spi_ctrl_types.tup2_1;
  signal s1                               : spi_ctrl_types.tup8;
  signal result_0                         : spi_ctrl_types.tup8;
  signal \#s1_case_alt\                   : spi_ctrl_types.tup8;
  signal result_1                         : spi_ctrl_types.tup8;
  signal \#app_arg\                       : std_logic_vector(7 downto 0);
  signal \#$sshiftBitInOutOut\            : spi_ctrl_types.tup2_1;
  signal \#$sshiftBitInOutOut_app_arg\    : std_logic_vector(7 downto 0);
  signal ds1_0                            : std_logic_vector(7 downto 0);
  signal miso1                            : std_logic;
  signal \#s1_case_alt_0\                 : spi_ctrl_types.tup8;
  signal \#s1_case_scrut\                 : boolean;
  signal \#spiCtrlOut_$jOut_app_arg\      : unsigned(2 downto 0);
  signal \buffer\                         : std_logic_vector(7 downto 0);
  signal \#s1_case_alt_1\                 : spi_ctrl_types.tup8;
  signal ds3                              : std_logic;
  signal ds2                              : std_logic;
  signal \#spiCtrlOut_$jOut_case_alt\     : unsigned(2 downto 0);
  signal \#spiCtrlOut_$jOut_case_alt_0\   : unsigned(2 downto 0);
  signal \#spiCtrlOut_$jOut_case_alt_1\   : unsigned(2 downto 0);
  signal \input'1\                        : spi_ctrl_types.connstd;
  signal \#spiCtrlOut_$jOut_case_scrut\   : boolean;
  signal \#spiCtrlOut_$jOut_case_alt_2\   : unsigned(2 downto 0);
  signal \#spiCtrlOut_$jOut_case_scrut_0\ : boolean;
begin
  result <= ( tup2_0_sel0 => ( tup3_sel0 => \clkOut\
            , tup3_sel1 => cs
            , tup3_sel2 => mosi )
            , tup2_0_sel1 => ( connstd_sel0 => \dataOut\
            , connstd_sel1 => \nextOutput\
            , connstd_sel2 => \busyOut\ ) );

  mosi <= ds1.tup2_1_sel1;

  counter <= s1.tup8_sel0;

  cs <= s1.tup8_sel2;

  \dataOut\ <= s1.tup8_sel3;

  \nextOutput\ <= s1.tup8_sel4;

  \clkOut\ <= s1.tup8_sel5;

  \busyOut\ <= s1.tup8_sel6;

  \stateL\ <= s1.tup8_sel7;

  ds1 <= s1.tup8_sel1;

  -- register begin 
  spi_ctrl_spictrl_sspictrl_register : process(clk,rst)
  begin
    if rst = '1' then
      s1 <= ( tup8_sel0 => to_unsigned(7,3), tup8_sel1 => ( tup2_1_sel0 => std_logic_vector'(x"00"), tup2_1_sel1 => '1' ), tup8_sel2 => '0', tup8_sel3 => std_logic_vector'(x"00"), tup8_sel4 => '0', tup8_sel5 => '0', tup8_sel6 => '0', tup8_sel7 => to_unsigned(4,3) )
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(clk) then
      s1 <= result_0
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  with (\stateL\) select
    result_0 <= \#s1_case_alt\ when "000",
                result_1 when "001",
                result_1 when "010",
                \#s1_case_alt_0\ when "011",
                \#s1_case_alt_1\ when "100",
                spi_ctrl_types.tup8'( unsigned'(0 to 2 => '-'), spi_ctrl_types.tup2_1'( std_logic_vector'(0 to 7 => '-'), '-' ), '-', std_logic_vector'(0 to 7 => '-'), '-', '-', '-', unsigned'(0 to 2 => '-') ) when others;

  \#s1_case_alt\ <= result_1 when \#s1_case_scrut\ else
                    \#s1_case_alt_0\;

  with (\#spiCtrlOut_$jOut_app_arg\) select
    result_1 <= ( tup8_sel0 => counter + to_unsigned(1,3)
                , tup8_sel1 => \#$sshiftBitInOutOut\
                , tup8_sel2 => '0'
                , tup8_sel3 => \dataOut\
                , tup8_sel4 => '0'
                , tup8_sel5 => '1'
                , tup8_sel6 => '1'
                , tup8_sel7 => \#spiCtrlOut_$jOut_app_arg\ ) when "000",
                ( tup8_sel0 => to_unsigned(0,3)
                , tup8_sel1 => \#$sshiftBitInOutOut\
                , tup8_sel2 => '0'
                , tup8_sel3 => \#app_arg\
                , tup8_sel4 => '1'
                , tup8_sel5 => '1'
                , tup8_sel6 => '1'
                , tup8_sel7 => \#spiCtrlOut_$jOut_app_arg\ ) when "001",
                ( tup8_sel0 => to_unsigned(7,3)
                , tup8_sel1 => ds1
                , tup8_sel2 => '1'
                , tup8_sel3 => \#app_arg\
                , tup8_sel4 => '1'
                , tup8_sel5 => '0'
                , tup8_sel6 => '0'
                , tup8_sel7 => \#spiCtrlOut_$jOut_app_arg\ ) when "010",
                ( tup8_sel0 => to_unsigned(7,3)
                , tup8_sel1 => ds1
                , tup8_sel2 => '0'
                , tup8_sel3 => \dataOut\
                , tup8_sel4 => '0'
                , tup8_sel5 => '0'
                , tup8_sel6 => '1'
                , tup8_sel7 => \#spiCtrlOut_$jOut_app_arg\ ) when "011",
                ( tup8_sel0 => to_unsigned(7,3)
                , tup8_sel1 => ds1
                , tup8_sel2 => '1'
                , tup8_sel3 => \dataOut\
                , tup8_sel4 => '0'
                , tup8_sel5 => '0'
                , tup8_sel6 => '0'
                , tup8_sel7 => \#spiCtrlOut_$jOut_app_arg\ ) when "100",
                spi_ctrl_types.tup8'( unsigned'(0 to 2 => '-'), spi_ctrl_types.tup2_1'( std_logic_vector'(0 to 7 => '-'), '-' ), '-', std_logic_vector'(0 to 7 => '-'), '-', '-', '-', unsigned'(0 to 2 => '-') ) when others;

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
      \#app_arg\ <= ivec;
    end process;
  end block;
  -- replaceBit end

  spi_ctrl_shiftbitinout_sshiftbitinoutout : entity spi_ctrl_shiftbitinout
    port map
      ( result => \#$sshiftBitInOutOut\
      , eta    => \#$sshiftBitInOutOut_app_arg\
      , eta1   => miso1 );

  with (\#spiCtrlOut_$jOut_app_arg\) select
    \#$sshiftBitInOutOut_app_arg\ <= \buffer\ when "000",
                                     ds1_0 when others;

  ds1_0 <= \input'1\.connstd_sel0;

  miso1 <= input.tup2_sel1;

  \#s1_case_alt_0\ <= \#s1_case_alt_1\ when \#spiCtrlOut_$jOut_case_scrut\ else
                      result_1;

  \#s1_case_scrut\ <= counter < to_unsigned(7,3);

  with (\stateL\) select
    \#spiCtrlOut_$jOut_app_arg\ <= \#spiCtrlOut_$jOut_case_alt_0\ when "000",
                                   to_unsigned(0,3) when "001",
                                   to_unsigned(4,3) when "010",
                                   \#spiCtrlOut_$jOut_case_alt_1\ when "011",
                                   \#spiCtrlOut_$jOut_case_alt\ when others;

  \buffer\ <= ds1.tup2_1_sel0;

  \#s1_case_alt_1\ <= result_1 when \#spiCtrlOut_$jOut_case_scrut_0\ else
                      result_1;

  ds3 <= \input'1\.connstd_sel2;

  ds2 <= \input'1\.connstd_sel1;

  \#spiCtrlOut_$jOut_case_alt\ <= to_unsigned(1,3) when \#spiCtrlOut_$jOut_case_scrut_0\ else
                                  to_unsigned(4,3);

  \#spiCtrlOut_$jOut_case_alt_0\ <= to_unsigned(0,3) when \#s1_case_scrut\ else
                                    \#spiCtrlOut_$jOut_case_alt_1\;

  \#spiCtrlOut_$jOut_case_alt_1\ <= \#spiCtrlOut_$jOut_case_alt_2\ when \#spiCtrlOut_$jOut_case_scrut\ else
                                    to_unsigned(3,3);

  \input'1\ <= input.tup2_sel0;

  \#spiCtrlOut_$jOut_case_scrut\ <= ds3 = ('0');

  \#spiCtrlOut_$jOut_case_alt_2\ <= to_unsigned(1,3) when \#spiCtrlOut_$jOut_case_scrut_0\ else
                                    to_unsigned(2,3);

  \#spiCtrlOut_$jOut_case_scrut_0\ <= ds2 = ('0');
end;

