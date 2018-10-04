module Modules.Interfaces.SPI.Designs.StreamR(main, version) where
import Clash.Explicit.Prelude
import ClashAddon
import ConnectorsStd
 
data CtrlState = LoadInput | Process | WriteOutput | Restart

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
      LoadInput -> Process
      Process -> case counter < (dataSize - 1) of
        True -> Process
        False -> WriteOutput
      WriteOutput -> Restart
      Restart -> LoadInput

    state' = case (stateNext) of
--                   (    counter,            (buffer, mosi),   cs,                dataOut,   NO, clkO,busyO,   stateL)
      LoadInput   -> (          0, shiftBitInOut dataIn miso,  low,                dataOut,  low, high, high, stateNext)
      Process     -> (counter + 1, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, stateNext)
      WriteOutput -> (          0, shiftBitInOut buffer miso,  low, shiftBitIn buffer miso, high, high, low, stateNext)
      Restart     -> (          0, shiftBitInOut buffer miso, high,                dataOut,  low,  low, high, stateNext)

ctrlOut state = output
  where
  (counter, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
  output = ((clkOut, cs, mosi), (ConnStd dataOut nextOutput busyOut))
  
main clk rst input (dataSize) = moore clk rst (ctrl (dataSize)) ctrlOut (0, (0, high), low, 0, low, low, low, Restart) input

getInfo = putStr "<empty>"