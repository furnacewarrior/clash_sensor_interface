module LightSensor_I where
import Clash.Explicit.Prelude
import ConnectorsStd

interface state input = (state', output)
  where
    dataIn = data# input
    sync = newByte# input

    dataOut = state
    dataOut' = case sync == high of
      True -> dataIn
      False -> dataOut
    state' = dataOut'
    response = ConnStd 0 low low
    output = (dataOut, response)

interface# clk rst = mealy clk rst interface 0

lightSensor_I :: Clock domain Source -> Reset domain Asynchronous -> Signal domain (ConnStd 8) -> Signal domain (BitVector 8, ConnStd 8)
lightSensor_I clk rst = interface# clk rst