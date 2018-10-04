library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package test_types is


  type connstd is record
    connstd_sel0 : std_logic_vector(7 downto 0);
    connstd_sel1 : std_logic;
    connstd_sel2 : std_logic;
  end record;
  function toSLV (slv : in std_logic_vector) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector;
  function toSLV (sl : in std_logic) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic;
  function toSLV (p : test_types.connstd) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return test_types.connstd;
end;

package body test_types is
  function toSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function toSLV (sl : in std_logic) return std_logic_vector is
  begin
    return std_logic_vector'(0 => sl);
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic is
    alias islv : std_logic_vector (0 to slv'length - 1) is slv;
  begin
    return islv(0);
  end;
  function toSLV (p : test_types.connstd) return std_logic_vector is
  begin
    return (toSLV(p.connstd_sel0) & toSLV(p.connstd_sel1) & toSLV(p.connstd_sel2));
  end;
  function fromSLV (slv : in std_logic_vector) return test_types.connstd is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 7)),fromSLV(islv(8 to 8)),fromSLV(islv(9 to 9)));
  end;
end;

