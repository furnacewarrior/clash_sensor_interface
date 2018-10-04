library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package testmachine_types is



  type tup2 is record
    tup2_sel0 : unsigned(7 downto 0);
    tup2_sel1 : unsigned(2 downto 0);
  end record;
  function toSLV (u : in unsigned) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return unsigned;
  function toSLV (sl : in std_logic) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic;
  function toSLV (p : testmachine_types.tup2) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return testmachine_types.tup2;
end;

package body testmachine_types is
  function toSLV (u : in unsigned) return std_logic_vector is
  begin
    return std_logic_vector(u);
  end;
  function fromSLV (slv : in std_logic_vector) return unsigned is
  begin
    return unsigned(slv);
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
  function toSLV (p : testmachine_types.tup2) return std_logic_vector is
  begin
    return (toSLV(p.tup2_sel0) & toSLV(p.tup2_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return testmachine_types.tup2 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 7)),fromSLV(islv(8 to 10)));
  end;
end;

