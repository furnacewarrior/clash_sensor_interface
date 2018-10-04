module ClashAddon where
import Clash.Explicit.Prelude

shiftBitInOut :: KnownNat a => BitVector a -> Bit -> (BitVector a, Bit)
shiftBitInOut vector bit = (bvNext', bvOut')
  where
    bvNext = shiftL vector 1
    bvNext' = replaceBit 0 bit bvNext
    bvOut' = msb vector

shiftBitIn :: KnownNat a => BitVector a -> Bit -> BitVector a
shiftBitIn vector bit = bvNext'
  where
    bvNext = shiftL vector 1
    bvNext' = replaceBit 0 bit bvNext

shiftBitOut :: KnownNat a => BitVector a -> (BitVector a, Bit)
shiftBitOut vector = (bvNext', bvOut') 
  where
    bvNext' = shiftL vector 1
    bvOut' = msb vector

clkConvert# :: KnownNat a => (Unsigned a, Bit) -> (Bit, Unsigned a) -> ((Unsigned a, Bit), Bit)
clkConvert# state input = (state', output)
  where
    (enable, factor) = input
    (counter, clkOut) = state
    state' = case enable==high of
      True -> case counter < factor of
        True -> (counter + 1, clkOut)
        False -> (0, complement clkOut)
      False -> (0, low)
    output = clkOut

clkConvert clk rst = mealy clk rst clkConvert# (0, low)