module LightSensorModel where
import Clash.Explicit.Prelude
import ClashAddon

sensor :: ((BitVector 15, Bit), Bool, Integer, Bit) -> (Bit, Bit) -> (((BitVector 15, Bit), Bool, Integer, Bit), (Bit)) 
sensor state input = (state', output)
  where
    (cs, mosi) = input
    outputValues = (0b000010110101000:>0b000011110001000:>0b000000110011000:>0b000011001100000:>0b000010101010000:>0b000011111111000:>Nil)
    ((buffer, miso), rising, counter, csPrev) = state

    counter' = case csPrev == high && cs == low of
      True -> counter + 1
      False -> counter

    state' = case cs == high of
      True -> ((outputValues!!counter, low), not rising, counter, cs)
      False -> case rising of
        True -> ((buffer, miso), False, counter', cs)
        False -> (shiftBitOut buffer, True, counter', cs)
    output = (miso)

sensor' clk rst = mealy clk rst sensor ((0b000010011001000, low), True, 0, high)

type DomainMult = Dom "sensor" 4500
lightSensorModel clk rst input = output
  where
    clk2 = clockGen :: Clock DomainMult Source
    rst2 = asyncResetGen :: Reset DomainMult Asynchronous
    miso = sensor' clk2 rst2 (unsafeSynchronizer clk clk2 input)
    output = unsafeSynchronizer clk2 clk miso

{-
type DomainUser = Dom "user" 9000
testSensor input = output
  where
    clk = clockGen :: Clock DomainUser Source
    rst = asyncResetGen :: Reset DomainUser Asynchronous
    output = lightSensorModel clk rst input

input = [(high, low),(high, low),(low, low),(low, low),(low, low),(low, low),(low, low),(low, low),
         (low, low),(low, low)  ,(low, low) ,(low, low),(low, low),(low, low),(low, low),(low, low),
         (low, low),(low, low)  ,(low, low) ,(low, low),(low, low),(low, low),(low, low),(low, low),
         (high, low),(high, low)  ,(low, low) ,(low, low),(low, low),(low, low),(low, low),(low, low),
         (low, low),(low, low)  ,(low, low) ,(high, low),(low, low),(low, low),(low, low),(low, low),
         (low, low),(low, low)  ,(low, low) ,(low, low),(low, low),(low, low),(low, low),(low, low),
         (low, low),(low, low),(low, low),(low, low),(low, low)]
-}