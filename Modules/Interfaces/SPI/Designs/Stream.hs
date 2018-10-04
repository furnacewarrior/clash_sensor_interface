module Modules.Interfaces.SPI.Designs.Stream(main, version) where
import Clash.Explicit.Prelude
import ClashAddon
import ConnectorsStd
 
data CtrlState = Init | ReadWrite | ReadWrite# | ReadWrite2 | RdInWrOut

version = "1.0"
ctrl :: (KnownNat a, c ~ (Unsigned 16, (BitVector a, Bit), Bit, BitVector a, Bit, Bit, Bit, CtrlState))
  => (Unsigned 16)
  -> c
  -> (ConnStd a, Bit)
  -> c
ctrl (dataSize) state input = state'
  where
    (input', miso) = input

    {-< Inputs >-}
    dataIn = data# input'
    newByte = newByte# input'
    busy = busy# input'

    {-< Load State >-}
    (counter, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state

    stateNext = case stateL of
      Init -> RdInWrOut
      ReadWrite -> case counter < (dataSize - 3) of
        True -> ReadWrite
        False -> ReadWrite#
      ReadWrite# -> ReadWrite2
      ReadWrite2 -> RdInWrOut
      RdInWrOut -> ReadWrite
  

    state' = case (stateNext) of
--                  (    counter,            (buffer, mosi),   cs,                dataOut,   NO, clkO,busyO,    stateL)
      Init       -> (          0, shiftBitInOut buffer miso, high,                dataOut,  low,  low,  low, stateNext)
      ReadWrite  -> (counter + 1, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, stateNext)
      ReadWrite# -> (          0, shiftBitInOut buffer miso,  low,                dataOut,  low, high,  low, stateNext)
      ReadWrite2 -> (          0, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, stateNext)
      RdInWrOut  -> (          0, shiftBitInOut dataIn miso,  low, shiftBitIn buffer miso, high, high, high, stateNext)

ctrlOut state = output
  where
  (counter, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
  output = ((clkOut, cs, mosi), (ConnStd dataOut nextOutput busyOut))
  
main clk rst input (dataSize) = moore clk rst (ctrl (dataSize)) ctrlOut (0, (0, high), low, 0, low, low, low, Init) input

getInfo = print "<empty>"