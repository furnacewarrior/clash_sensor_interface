module LightSensorModel where
import Clash.Explicit.Prelude
import ClashAddon

sensor :: ((BitVector 16, Bit), Bool) -> (Bit, Bit) -> (((BitVector 16, Bit), Bool), (Bit)) 
sensor state input = (state', output)
  where
    (cs, mosi) = input
    ((buffer, miso), rising) = state
    state' = case cs == high of
      True -> ((buffer, low), not rising)
      False -> case rising of
        True -> ((buffer, miso), False)
        False -> (shiftBitOut buffer, True)
    output = (miso)

sensor' clk rst = mealy clk rst sensor ((0b0000101101010000, low), True)

type DomainMult = Dom "user" 4500
lightSensorModel clk rst input = output
  where
    clk2 = clockGen :: Clock DomainMult Source
    rst2 = asyncResetGen :: Reset DomainMult Asynchronous
    miso = sensor' clk2 rst2 (unsafeSynchronizer clk clk2 input)
    output = unsafeSynchronizer clk2 clk miso

{-
type DomainUser = Dom "user" 9000
testobject input = output 
  where
    clkA = clockGen :: Clock DomainUser Source
    rstA = asyncResetGen :: Reset DomainUser Asynchronous
    output = sensor' clkA rstA input

testinput = [(low, low), (low, low), (low, low), (low, low),
             (low, low), (low, low), (low, low), (low, low),
             (low, low), (low, low), (low, low), (low, low)]
-}