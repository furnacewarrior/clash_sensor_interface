library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package spi_ctrl_types is

  type tup3 is record
    tup3_sel0 : std_logic;
    tup3_sel1 : std_logic;
    tup3_sel2 : std_logic;
  end record;

  type tup2_1 is record
    tup2_1_sel0 : std_logic_vector(7 downto 0);
    tup2_1_sel1 : std_logic;
  end record;


  type gatedclock is record
    gatedclock_sel0 : std_logic;
    gatedclock_sel1 : boolean;
  end record;
  type connstd is record
    connstd_sel0 : std_logic_vector(7 downto 0);
    connstd_sel1 : std_logic;
    connstd_sel2 : std_logic;
  end record;
  type tup2_2 is record
    tup2_2_sel0 : std_logic;
    tup2_2_sel1 : std_logic;
  end record;
  type tup3_0 is record
    tup3_0_sel0 : spi_ctrl_types.tup2_2;
    tup3_0_sel1 : spi_ctrl_types.connstd;
    tup3_0_sel2 : spi_ctrl_types.gatedclock;
  end record;
  type tup2 is record
    tup2_sel0 : spi_ctrl_types.connstd;
    tup2_sel1 : std_logic;
  end record;
  type tup2_0 is record
    tup2_0_sel0 : spi_ctrl_types.tup3;
    tup2_0_sel1 : spi_ctrl_types.connstd;
  end record;
  type tup8 is record
    tup8_sel0 : unsigned(2 downto 0);
    tup8_sel1 : spi_ctrl_types.tup2_1;
    tup8_sel2 : std_logic;
    tup8_sel3 : std_logic_vector(7 downto 0);
    tup8_sel4 : std_logic;
    tup8_sel5 : std_logic;
    tup8_sel6 : std_logic;
    tup8_sel7 : unsigned(2 downto 0);
  end record;
  function toSLV (sl : in std_logic) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic;
  function toSLV (p : spi_ctrl_types.tup3) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup3;
  function toSLV (slv : in std_logic_vector) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector;
  function toSLV (p : spi_ctrl_types.tup2_1) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2_1;
  function toSLV (u : in unsigned) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return unsigned;
  function toSLV (b : in boolean) return std_logic_vector;
  function fromSLV (sl : in std_logic_vector) return boolean;
  function tagToEnum (s : in signed) return boolean;
  function dataToTag (b : in boolean) return signed;
  function toSLV (p : spi_ctrl_types.gatedclock) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.gatedclock;
  function toSLV (p : spi_ctrl_types.connstd) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.connstd;
  function toSLV (p : spi_ctrl_types.tup2_2) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2_2;
  function toSLV (p : spi_ctrl_types.tup3_0) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup3_0;
  function toSLV (p : spi_ctrl_types.tup2) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2;
  function toSLV (p : spi_ctrl_types.tup2_0) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2_0;
  function toSLV (p : spi_ctrl_types.tup8) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup8;
end;

package body spi_ctrl_types is
  function toSLV (sl : in std_logic) return std_logic_vector is
  begin
    return std_logic_vector'(0 => sl);
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic is
    alias islv : std_logic_vector (0 to slv'length - 1) is slv;
  begin
    return islv(0);
  end;
  function toSLV (p : spi_ctrl_types.tup3) return std_logic_vector is
  begin
    return (toSLV(p.tup3_sel0) & toSLV(p.tup3_sel1) & toSLV(p.tup3_sel2));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup3 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 0)),fromSLV(islv(1 to 1)),fromSLV(islv(2 to 2)));
  end;
  function toSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function toSLV (p : spi_ctrl_types.tup2_1) return std_logic_vector is
  begin
    return (toSLV(p.tup2_1_sel0) & toSLV(p.tup2_1_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2_1 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 7)),fromSLV(islv(8 to 8)));
  end;
  function toSLV (u : in unsigned) return std_logic_vector is
  begin
    return std_logic_vector(u);
  end;
  function fromSLV (slv : in std_logic_vector) return unsigned is
  begin
    return unsigned(slv);
  end;
  function toSLV (b : in boolean) return std_logic_vector is
  begin
    if b then
      return "1";
    else
      return "0";
    end if;
  end;
  function fromSLV (sl : in std_logic_vector) return boolean is
  begin
    if sl = "1" then
      return true;
    else
      return false;
    end if;
  end;
  function tagToEnum (s : in signed) return boolean is
  begin
    if s = to_signed(0,64) then
      return false;
    else
      return true;
    end if;
  end;
  function dataToTag (b : in boolean) return signed is
  begin
    if b then
      return to_signed(1,64);
    else
      return to_signed(0,64);
    end if;
  end;
  function toSLV (p : spi_ctrl_types.gatedclock) return std_logic_vector is
  begin
    return (toSLV(p.gatedclock_sel0) & toSLV(p.gatedclock_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.gatedclock is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 0)),fromSLV(islv(1 to 1)));
  end;
  function toSLV (p : spi_ctrl_types.connstd) return std_logic_vector is
  begin
    return (toSLV(p.connstd_sel0) & toSLV(p.connstd_sel1) & toSLV(p.connstd_sel2));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.connstd is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 7)),fromSLV(islv(8 to 8)),fromSLV(islv(9 to 9)));
  end;
  function toSLV (p : spi_ctrl_types.tup2_2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_2_sel0) & toSLV(p.tup2_2_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2_2 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 0)),fromSLV(islv(1 to 1)));
  end;
  function toSLV (p : spi_ctrl_types.tup3_0) return std_logic_vector is
  begin
    return (toSLV(p.tup3_0_sel0) & toSLV(p.tup3_0_sel1) & toSLV(p.tup3_0_sel2));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup3_0 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 1)),fromSLV(islv(2 to 11)),fromSLV(islv(12 to 13)));
  end;
  function toSLV (p : spi_ctrl_types.tup2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_sel0) & toSLV(p.tup2_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 9)),fromSLV(islv(10 to 10)));
  end;
  function toSLV (p : spi_ctrl_types.tup2_0) return std_logic_vector is
  begin
    return (toSLV(p.tup2_0_sel0) & toSLV(p.tup2_0_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup2_0 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 2)),fromSLV(islv(3 to 12)));
  end;
  function toSLV (p : spi_ctrl_types.tup8) return std_logic_vector is
  begin
    return (toSLV(p.tup8_sel0) & toSLV(p.tup8_sel1) & toSLV(p.tup8_sel2) & toSLV(p.tup8_sel3) & toSLV(p.tup8_sel4) & toSLV(p.tup8_sel5) & toSLV(p.tup8_sel6) & toSLV(p.tup8_sel7));
  end;
  function fromSLV (slv : in std_logic_vector) return spi_ctrl_types.tup8 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 2)),fromSLV(islv(3 to 11)),fromSLV(islv(12 to 12)),fromSLV(islv(13 to 20)),fromSLV(islv(21 to 21)),fromSLV(islv(22 to 22)),fromSLV(islv(23 to 23)),fromSLV(islv(24 to 26)));
  end;
end;

