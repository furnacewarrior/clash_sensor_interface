module LightSensor_I where
import Clash.Explicit.Prelude
import Connectors_Sync

interface state input = (state', output)
  where
    dataIn = data# input
    sync = sync# input

    dataOut = state
    dataOut' = case sync == high of
      True -> dataIn
      False -> dataOut
    state' = dataOut'
    output = dataOut

interface# clk rst = mealy clk rst interface 0

lightSensor_I :: Clock domain Source -> Reset domain Asynchronous -> Signal domain (DataSync 8) -> Signal domain (BitVector 8)
lightSensor_I clk rst = interface# clk rst