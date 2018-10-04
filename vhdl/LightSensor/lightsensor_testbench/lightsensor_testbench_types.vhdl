library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package lightsensor_testbench_types is




  type gatedclock is record
    gatedclock_sel0 : std_logic;
    gatedclock_sel1 : boolean;
  end record;
  type tup4 is record
    tup4_sel0 : std_logic_vector(7 downto 0);
    tup4_sel1 : std_logic;
    tup4_sel2 : std_logic;
    tup4_sel3 : lightsensor_testbench_types.gatedclock;
  end record;

  type array_of_std_logic is array (integer range <>) of std_logic;
  function toSLV (slv : in std_logic_vector) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector;
  function toSLV (u : in unsigned) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return unsigned;
  function toSLV (b : in boolean) return std_logic_vector;
  function fromSLV (sl : in std_logic_vector) return boolean;
  function tagToEnum (s : in signed) return boolean;
  function dataToTag (b : in boolean) return signed;
  function toSLV (sl : in std_logic) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return std_logic;
  function toSLV (p : lightsensor_testbench_types.gatedclock) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return lightsensor_testbench_types.gatedclock;
  function toSLV (p : lightsensor_testbench_types.tup4) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return lightsensor_testbench_types.tup4;
  function toSLV (s : in signed) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return signed;
  function toSLV (value :  lightsensor_testbench_types.array_of_std_logic) return std_logic_vector;
  function fromSLV (slv : in std_logic_vector) return lightsensor_testbench_types.array_of_std_logic;
end;

package body lightsensor_testbench_types is
  function toSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic_vector is
  begin
    return slv;
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
  function toSLV (sl : in std_logic) return std_logic_vector is
  begin
    return std_logic_vector'(0 => sl);
  end;
  function fromSLV (slv : in std_logic_vector) return std_logic is
    alias islv : std_logic_vector (0 to slv'length - 1) is slv;
  begin
    return islv(0);
  end;
  function toSLV (p : lightsensor_testbench_types.gatedclock) return std_logic_vector is
  begin
    return (toSLV(p.gatedclock_sel0) & toSLV(p.gatedclock_sel1));
  end;
  function fromSLV (slv : in std_logic_vector) return lightsensor_testbench_types.gatedclock is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 0)),fromSLV(islv(1 to 1)));
  end;
  function toSLV (p : lightsensor_testbench_types.tup4) return std_logic_vector is
  begin
    return (toSLV(p.tup4_sel0) & toSLV(p.tup4_sel1) & toSLV(p.tup4_sel2) & toSLV(p.tup4_sel3));
  end;
  function fromSLV (slv : in std_logic_vector) return lightsensor_testbench_types.tup4 is
  alias islv : std_logic_vector(0 to slv'length - 1) is slv;
  begin
    return (fromSLV(islv(0 to 7)),fromSLV(islv(8 to 8)),fromSLV(islv(9 to 9)),fromSLV(islv(10 to 11)));
  end;
  function toSLV (s : in signed) return std_logic_vector is
  begin
    return std_logic_vector(s);
  end;
  function fromSLV (slv : in std_logic_vector) return signed is
  begin
    return signed(slv);
  end;
  function toSLV (value :  lightsensor_testbench_types.array_of_std_logic) return std_logic_vector is
    alias ivalue    : lightsensor_testbench_types.array_of_std_logic(1 to value'length) is value;
    variable result : std_logic_vector(1 to value'length * 1);
  begin
    for i in ivalue'range loop
      result(((i - 1) * 1) + 1 to i*1) := toSLV(ivalue(i));
    end loop;
    return result;
  end;
  function fromSLV (slv : in std_logic_vector) return lightsensor_testbench_types.array_of_std_logic is
    alias islv      : std_logic_vector(0 to slv'length - 1) is slv;
    variable result : lightsensor_testbench_types.array_of_std_logic(0 to slv'length / 1 - 1);
  begin
    for i in result'range loop
      result(i) := fromSLV(islv(i * 1 to (i+1) * 1 - 1));
    end loop;
    return result;
  end;
end;

