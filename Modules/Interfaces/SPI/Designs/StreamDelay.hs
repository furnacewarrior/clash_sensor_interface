module Modules.Interfaces.SPI.Designs.StreamDelay(main, version) where
import Clash.Explicit.Prelude
import ClashAddon
import ConnectorsStd
 
data CtrlState = Init | Process | ProcessEnd | HoldStart | HoldStartS | Hold | HoldS | HoldEnd

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
      2 -> stateM_2
      3 -> stateM_3
      _ -> stateM_4

    stateM_1 = case stateL of
      Init -> HoldEnd
      Process -> case counter < (dataSize - 2) of
                  True -> Process
                  False -> ProcessEnd
      ProcessEnd -> HoldStart
      HoldStart -> HoldEnd  
      HoldEnd -> Process
      _ -> Init
 
    stateM_2 = case stateL of
      Init -> HoldEnd
      Process -> case counter < (dataSize - 1) of
                   True -> Process
                   False -> HoldStartS
      HoldStartS -> Hold
      Hold -> HoldEnd  
      HoldEnd -> Process
      _ -> Init

    stateM_3 = case stateL of
      Init -> HoldEnd
      Process -> case counter < (dataSize - 1) of
                   True -> Process
                   False -> HoldStart
      HoldStart -> HoldS
      HoldS -> Hold
      Hold -> HoldEnd
      HoldEnd -> Process
      _ -> Init

    stateM_4 = case stateL of
      Init -> HoldEnd
      Process -> case counter < (dataSize - 1) of
                   True -> Process
                   False -> HoldStart
      HoldStart -> Hold
      Hold -> case (counterDelay == (delay - 3)) of
        True -> HoldS
        False -> case (counterDelay < delay) of 
          True -> Hold
          False -> HoldEnd
      HoldEnd -> Process
      _ -> Init

    state' = case (stateNext) of
--                 (    counter,     counterDelay,            (buffer, mosi),   cs,                dataOut,   NO, clkO,busyO,   stateL)
      Init      -> (          0,                0, shiftBitInOut buffer miso, high,                dataOut,  low,  low, high, stateNext)
      Process   -> (counter + 1,                0, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, stateNext)
      ProcessEnd-> (          0,                0, shiftBitInOut buffer miso,  low,                dataOut,  low, high,  low, stateNext)
      HoldStart -> (          0, counterDelay + 1, shiftBitInOut buffer miso,  low, shiftBitIn buffer miso, high,  low, high, stateNext)
      HoldStartS-> (          0, counterDelay + 1, shiftBitInOut buffer miso,  low, shiftBitIn buffer miso, high,  low,  low, stateNext)
      Hold      -> (          0, counterDelay + 1, shiftBitInOut buffer miso,  low,                dataOut,  low,  low, high, stateNext)
      HoldS      ->(          0, counterDelay + 1, shiftBitInOut buffer miso,  low,                dataOut,  low,  low,  low, stateNext)
      HoldEnd   -> (          0,                0, shiftBitInOut dataIn miso,  low,                dataOut,  low, high, high, stateNext)

ctrlOut state = output
  where
  (counter, counterDelay, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
  output = ((clkOut, cs, mosi), (ConnStd dataOut nextOutput busyOut))
  
main clk rst input (dataSize, delay) = moore clk rst (ctrl (dataSize, delay)) ctrlOut (0, 1, (0, high), low, 0, low, low, low, Init) input

getInfo = print "<empty>"