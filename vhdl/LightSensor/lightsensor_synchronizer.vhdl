-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity lightsensor_synchronizer is
  port(-- clock
       \clkA\ : in std_logic;
       -- asynchronous reset: active high
       \rstA\ : in std_logic;
       -- clock
       \clkB\ : in std_logic;
       -- asynchronous reset: active high
       \rstB\ : in std_logic;
       ds1    : in lightsensor_types.tup2;
       result : out lightsensor_types.tup2);
end;

architecture structural of lightsensor_synchronizer is
  signal \domAOut\     : lightsensor_types.connstd;
  signal \domBOut\     : lightsensor_types.connstd;
  signal result_0      : lightsensor_types.tup2;
  signal \dataOutA\    : std_logic_vector(7 downto 0);
  signal \syncOutA\    : std_logic;
  signal \busyOutA\    : std_logic;
  signal \dataOutB\    : std_logic_vector(7 downto 0);
  signal \syncOutB\    : std_logic;
  signal \busyOutB\    : std_logic;
  signal ds2           : lightsensor_types.tup3;
  signal ds1_0         : lightsensor_types.tup3;
  signal ds1_1         : std_logic_vector(7 downto 0);
  signal ds2_0         : std_logic;
  signal ds3           : std_logic;
  signal ds1_2         : std_logic_vector(7 downto 0);
  signal ds2_1         : std_logic;
  signal ds3_0         : std_logic;
  signal \domAIn\      : lightsensor_types.connstd;
  signal \domBIn\      : lightsensor_types.connstd;
  signal ds2_fun_arg   : lightsensor_types.tup3;
  signal ds1_0_fun_arg : lightsensor_types.tup3;
begin
  result <= ( tup2_sel0 => \domAOut\
            , tup2_sel1 => \domBOut\ );

  \domAOut\ <= result_0.tup2_sel0;

  \domBOut\ <= result_0.tup2_sel1;

  result_0 <= ( tup2_sel0 => ( connstd_sel0 => \dataOutA\
              , connstd_sel1 => \syncOutA\
              , connstd_sel2 => \busyOutA\ )
              , tup2_sel1 => ( connstd_sel0 => \dataOutB\
              , connstd_sel1 => \syncOutB\
              , connstd_sel2 => \busyOutB\ ) );

  \dataOutA\ <= ds1_0.tup3_sel0;

  \syncOutA\ <= ds1_0.tup3_sel1;

  \busyOutA\ <= ds2.tup3_sel2;

  \dataOutB\ <= ds2.tup3_sel0;

  \syncOutB\ <= ds2.tup3_sel1;

  \busyOutB\ <= ds1_0.tup3_sel2;

  ds2_fun_arg <= ( tup3_sel0 => ds1_1
                 , tup3_sel1 => ds2_0
                 , tup3_sel2 => ds3 );

  syncsafe_syncsafe_ssync_safe_ds2 : entity syncsafe_syncsafe_ssync_safe
    port map
      ( result => ds2
      , \clkA\ => \clkA\
      , \rstA\ => \rstA\
      , \clkB\ => \clkB\
      , \rstB\ => \rstB\
      , ds     => ds2_fun_arg );

  ds1_0_fun_arg <= ( tup3_sel0 => ds1_2
                   , tup3_sel1 => ds2_1
                   , tup3_sel2 => ds3_0 );

  syncsafe_syncsafe_ssync_safe_0_ds1_0 : entity syncsafe_syncsafe_ssync_safe_0
    port map
      ( result => ds1_0
      , \clkA\ => \clkB\
      , \rstA\ => \rstB\
      , \clkB\ => \clkA\
      , \rstB\ => \rstA\
      , ds     => ds1_0_fun_arg );

  ds1_1 <= \domAIn\.connstd_sel0;

  ds2_0 <= \domAIn\.connstd_sel1;

  ds3 <= \domBIn\.connstd_sel2;

  ds1_2 <= \domBIn\.connstd_sel0;

  ds2_1 <= \domBIn\.connstd_sel1;

  ds3_0 <= \domAIn\.connstd_sel2;

  \domAIn\ <= ds1.tup2_sel0;

  \domBIn\ <= ds1.tup2_sel1;
end;

