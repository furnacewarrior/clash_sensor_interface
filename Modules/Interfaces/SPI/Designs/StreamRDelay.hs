module Modules.Interfaces.SPI.Designs.StreamRDelay(main, version) where
import Clash.Explicit.Prelude
import ClashAddon
import ConnectorsStd
 
data CtrlState = LoadInput | ReadWrite | WriteOutput | Restart | Restart# | Restart2

version = "1.0"

ctrl :: (KnownNat a, c ~ (Unsigned 16, Unsigned 16, (BitVector a, Bit), Bit, BitVector a, Bit, Bit, Bit, CtrlState)) 
  => (Unsigned 16, Unsigned 16)
  -> c
  -> (ConnStd a, Bit)
  -> c
ctrl (dataSize, delay) state input = state'
  where
    (input', miso) = input

    {-< Inputs >-}
    dataIn = data# input'
    newByte = newByte# input'
    busy = busy# input'

    {-< Load State >-}
    (counter, counterDelay, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
    
    stateNext = case delay of
      1 -> stateM_1
      _ -> stateM_2

    stateM_1 = case stateL of
      LoadInput -> ReadWrite
      ReadWrite -> case counter < (dataSize - 1) of
        True -> ReadWrite
        False -> WriteOutput
      WriteOutput -> Restart#
      Restart# -> Restart
      Restart -> LoadInput
      _ -> Restart

    stateM_2 = case stateL of
      LoadInput -> ReadWrite
      ReadWrite -> case counter < (dataSize - 1) of
        True -> ReadWrite
        False -> WriteOutput
      WriteOutput -> Restart   
      Restart -> case counterDelay == delay - 1 of
        True -> Restart#
        False -> Restart
      Restart# -> Restart2
      Restart2 -> LoadInput 

    state' = case (stateNext) of
--                  (    counter,     counterDelay,            (buffer, mosi),   cs,                dataOut,   NO, clkO,busyO,   stateL)
      LoadInput  -> (          0,                0, shiftBitInOut dataIn miso,  low,                dataOut,  low, high, high, stateNext)
      ReadWrite  -> (counter + 1,                0, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, stateNext)
      WriteOutput-> (          0,                0, shiftBitInOut buffer miso,  low, shiftBitIn buffer miso, high, high, high, stateNext)
      Restart    -> (          0, counterDelay + 1, shiftBitInOut buffer miso, high,                dataOut,  low,  low, high, stateNext)
      Restart#   -> (          0,                0, shiftBitInOut buffer miso, high,                dataOut,  low,  low,  low, stateNext)
      Restart2   -> (          0,                0, shiftBitInOut buffer miso, high,                dataOut,  low,  low, high, stateNext)


ctrlOut state = output
  where
  (counter, counterDelay, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
  output = ((clkOut, cs, mosi), (ConnStd dataOut nextOutput busyOut))
  
main clk rst input (dataSize, delay) = moore clk rst (ctrl (dataSize, delay)) ctrlOut (0, 0, (0, high), low, 0, low, low, low, Restart) input

getInfo = putStr "<empty>"