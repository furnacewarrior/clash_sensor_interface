module Modules.Interfaces.SPI.Designs.Std(main, version) where
import Clash.Explicit.Prelude
import ClashAddon
import ConnectorsStd

data CtrlState = ReadWrite | ReadWrite2 | ReadWrite# | WriteRestart | WriteHold | WaitBusy | WaitFinished | Restart

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
    finished = newByte# input'
    busy = busy# input'

    {-< Load State >-}
    (counter, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
    
    newState = case stateL of
      ReadWrite -> case counter < (dataSize - 3) of
        True -> ReadWrite
        False -> ReadWrite#
      ReadWrite# -> ReadWrite2
      ReadWrite2 -> case (busy == low, finished == high) of
        (True, True) -> WriteRestart
        (True, False) -> WriteHold
        (False, True) -> WaitBusy
        (False, False) -> WaitBusy
      WriteRestart -> ReadWrite
      WriteHold -> WaitFinished
      WaitBusy -> case (busy == low, finished == high) of
        (True, True) -> WriteRestart
        (True, False) -> WriteHold
        (False, True) -> WaitBusy
        (False, False) -> WaitBusy
      WaitFinished -> case (finished == high) of
        True -> Restart
        False -> WaitFinished
      Restart -> ReadWrite

    state' = case (newState) of
--                    (    counter,            (buffer, mosi),   cs,                dataOut,   NO, clkO,busyO,   stateL)
      ReadWrite    -> (counter + 1, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, newState)
      ReadWrite#   -> (          0, shiftBitInOut buffer miso,  low,                dataOut,  low, high,  low, newState)
      ReadWrite2   -> (          0, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, newState)
      Restart      -> (          0, shiftBitInOut dataIn miso,  low,                dataOut,  low, high, high, newState)
      WriteRestart -> (          0, shiftBitInOut dataIn miso,  low, shiftBitIn buffer miso, high, high, high, newState)
      WriteHold    -> (          0,            (buffer, mosi),  low, shiftBitIn buffer miso, high,  low, high, newState)
      WaitBusy     -> (          0,            (buffer, mosi),  low,                dataOut,  low,  low, high, newState)
      WaitFinished -> (          0,            (buffer, mosi), high,                dataOut,  low,  low, high, newState)

ctrlOut state = output
  where
  (counter, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
  output = ((clkOut, cs, mosi), (ConnStd dataOut nextOutput busyOut))
  
main clk rst input (dataSize) = moore clk rst (ctrl (dataSize)) ctrlOut (0, (0, high), low, 0, low, low, low, WaitFinished) input

getInfo = print "<empty>"