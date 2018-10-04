-- Automatically generated VHDL-93
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;
use std.textio.all;
use work.all;
use work.lightsensor_types.all;

entity syncsafe_syncsafe_ssync_safe is
  port(-- clock
       \clkA\ : in std_logic;
       -- asynchronous reset: active high
       \rstA\ : in std_logic;
       -- clock
       \clkB\ : in std_logic;
       -- asynchronous reset: active high
       \rstB\ : in std_logic;
       ds     : in lightsensor_types.tup3;
       result : out lightsensor_types.tup3);
end;

architecture structural of syncsafe_syncsafe_ssync_safe is
  signal busy                   : std_logic;
  signal sync                   : std_logic;
  signal message                : std_logic_vector(7 downto 0);
  signal \sync'\                : boolean;
  signal \syncEn\               : boolean;
  signal \busyOut\              : boolean;
  signal result_0               : boolean;
  signal f2                     : boolean;
  signal result_1               : boolean;
  signal x                      : boolean;
  signal result_2               : boolean;
  signal x_0                    : std_logic;
  signal \#feedback_app_arg\    : boolean;
  signal result_3               : boolean;
  signal x_1                    : boolean;
  signal \#syncEn'_app_arg\     : boolean;
  signal \#app_arg\             : std_logic;
  signal result_4               : std_logic;
  signal x_2                    : boolean;
  signal \#x_app_arg\           : boolean;
  signal \#app_arg_0\           : std_logic_vector(7 downto 0);
  signal \#app_arg_1\           : std_logic_vector(7 downto 0);
  signal \#app_arg_2\           : lightsensor_types.gatedclock;
  signal \#app_arg_3\           : std_logic;
  signal \#app_arg_4\           : std_logic;
  signal \#app_arg_5\           : lightsensor_types.gatedclock;
  signal result_2_selection_res : boolean;
  signal \#i\                   : signed(63 downto 0);
  signal \#i_0\                 : signed(63 downto 0);
  signal \#i_1\                 : signed(63 downto 0);
  signal \#i_2\                 : signed(63 downto 0);
begin
  busy <= ds.tup3_sel2;

  sync <= ds.tup3_sel1;

  message <= ds.tup3_sel0;

  result <= ( tup3_sel0 => \#app_arg_0\
            , tup3_sel1 => result_4
            , tup3_sel2 => \#app_arg\ );

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register : process(\clkA\,\rstA\)
  begin
    if \rstA\ = '1' then
      \sync'\ <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkA\) then
      \sync'\ <= result_0
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  \syncEn\ <= ((std_logic_vector'(0 => sync)) = std_logic_vector'("1")) and (not \busyOut\);

  \busyOut\ <= result_1 or \sync'\;

  result_0 <= true when \syncEn\ else
              f2;

  f2 <= false when result_1 else
        \sync'\;

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_0 : process(\clkA\,\rstA\)
  begin
    if \rstA\ = '1' then
      result_1 <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkA\) then
      result_1 <= \#feedback_app_arg\
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  x <= result_2;

  result_2_selection_res <= (std_logic_vector'(0 => x_0)) = std_logic_vector'("1");

  result_2 <= true when result_2_selection_res else
              result_3;

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_1 : process(\clkB\,\rstB\)
  begin
    if \rstB\ = '1' then
      x_0 <= ('0')
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkB\) then
      x_0 <= busy
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_2 : process(\clkA\,\rstA\)
  begin
    if \rstA\ = '1' then
      \#feedback_app_arg\ <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkA\) then
      \#feedback_app_arg\ <= x
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_3 : process(\clkB\,\rstB\)
  begin
    if \rstB\ = '1' then
      result_3 <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkB\) then
      result_3 <= \#syncEn'_app_arg\
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  x_1 <= \sync'\;

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_4 : process(\clkB\,\rstB\)
  begin
    if \rstB\ = '1' then
      \#syncEn'_app_arg\ <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkB\) then
      \#syncEn'_app_arg\ <= x_1
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  \#i\ <= to_signed(0,64);

  \#i_0\ <= to_signed(1,64);

  \#app_arg\ <= '1' when \busyOut\ else
                '0';

  \#i_1\ <= to_signed(0,64);

  \#i_2\ <= to_signed(1,64);

  result_4 <= '1' when x_2 else
              '0';

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_5 : process(\clkB\,\rstB\)
  begin
    if \rstB\ = '1' then
      x_2 <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkB\) then
      x_2 <= ((not \#x_app_arg\) and result_3)
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  -- register begin 
  syncsafe_syncsafe_ssync_safe_register_6 : process(\clkB\,\rstB\)
  begin
    if \rstB\ = '1' then
      \#x_app_arg\ <= false
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    elsif rising_edge(\clkB\) then
      \#x_app_arg\ <= result_3
      -- pragma translate_off
      after 1 ps
      -- pragma translate_on
      ;
    end if;
  end process;
  -- register end

  -- register begin
  syncsafe_syncsafe_ssync_safe_register_7 : block
    signal clk_7 : std_logic;
    signal ce_7 : boolean;
  begin
    (clk_7,ce_7) <= \#app_arg_5\;
    syncsafe_syncsafe_ssync_safe_reg_7 : process(clk_7,\rstB\)
    begin
      if \rstB\ = '1' then
        \#app_arg_0\ <= std_logic_vector'(x"00");
      elsif rising_edge(clk_7) then
        if ce_7 then
          \#app_arg_0\ <= (\#app_arg_1\)
          -- pragma translate_off
          after 1 ps
          -- pragma translate_on
          ;
        end if;
      end if;
    end process;
  end block;
  -- register end

  -- register begin
  syncsafe_syncsafe_ssync_safe_register_8 : block
    signal clk_8 : std_logic;
    signal ce_8 : boolean;
  begin
    (clk_8,ce_8) <= \#app_arg_2\;
    syncsafe_syncsafe_ssync_safe_reg_8 : process(clk_8,\rstA\)
    begin
      if \rstA\ = '1' then
        \#app_arg_1\ <= std_logic_vector'(x"00");
      elsif rising_edge(clk_8) then
        if ce_8 then
          \#app_arg_1\ <= message
          -- pragma translate_off
          after 1 ps
          -- pragma translate_on
          ;
        end if;
      end if;
    end process;
  end block;
  -- register end

  -- clockGate begin
  \#app_arg_2\ <= (\clkA\,\syncEn\);
  -- clockGate end

  \#app_arg_3\ <= '-';

  \#app_arg_4\ <= '-';

  -- clockGate begin
  \#app_arg_5\ <= (\clkB\,result_3);
  -- clockGate end
end;

