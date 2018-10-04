module Modules.Interfaces.SPI.Designs.StreamDelay(main, version) where
import Clash.Explicit.Prelude
import ClashAddon
import ConnectorsStd
 
data CtrlState = Init | ReadWrite | ReadWrite# | WriteData | WriteData# | Hold | Hold2 | Hold# | ReadData | HoldPreEnd

-- # means the busy signal is reset here
-- number means same state but has different name for state machine
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
      Init -> ReadData
      ReadWrite -> case counter < (dataSize - 2) of
                  True -> ReadWrite
                  False -> ReadWrite#
      ReadWrite# -> WriteData
      WriteData -> ReadData  
      ReadData -> ReadWrite
      _ -> Init
 
    stateM_2 = case stateL of
      Init -> ReadData
      ReadWrite -> case counter < (dataSize - 1) of
                   True -> ReadWrite
                   False -> WriteData#
      WriteData# -> Hold
      Hold -> ReadData  
      ReadData -> ReadWrite
      _ -> Init

    stateM_3 = case stateL of
      Init -> ReadData
      ReadWrite -> case counter < (dataSize - 1) of
                   True -> ReadWrite
                   False -> WriteData
      WriteData -> Hold#
      Hold# -> Hold
      Hold -> ReadData
      ReadData -> ReadWrite
      _ -> Init

    stateM_4 = case stateL of
      Init -> ReadData
      ReadWrite -> case counter < (dataSize - 1) of
                   True -> ReadWrite
                   False -> WriteData
      WriteData -> Hold
      Hold -> case (counterDelay == (delay - 3)) of
        True -> Hold#
        False -> Hold
      Hold# -> Hold2
	  Hold2 -> ReadData
      ReadData -> ReadWrite
      _ -> Init

    state' = case (stateNext) of
--                   (    counter,     counterDelay,            (buffer, mosi),   cs,                dataOut,   NO, clkO,busyO,   stateL)
      Init        -> (          0,                0, shiftBitInOut buffer miso, high,                dataOut,  low,  low, high, stateNext)
      ReadWrite   -> (counter + 1,                0, shiftBitInOut buffer miso,  low,                dataOut,  low, high, high, stateNext)
      ReadWrite#  -> (          0,                0, shiftBitInOut buffer miso,  low,                dataOut,  low, high,  low, stateNext)
      WriteData   -> (          0,                0, shiftBitInOut buffer miso,  low, shiftBitIn buffer miso, high,  low, high, stateNext)
      WriteData#  -> (          0,                0, shiftBitInOut buffer miso,  low, shiftBitIn buffer miso, high,  low,  low, stateNext)
      Hold, Hold2 -> (          0, counterDelay + 1, shiftBitInOut buffer miso,  low,                dataOut,  low,  low, high, stateNext)
      Hold#       -> (          0,                0, shiftBitInOut buffer miso,  low,                dataOut,  low,  low,  low, stateNext)
      ReadData    -> (          0,                0, shiftBitInOut dataIn miso,  low,                dataOut,  low, high, high, stateNext)

ctrlOut state = output
  where
  (counter, counterDelay, (buffer, mosi), cs, dataOut, nextOutput, clkOut, busyOut, stateL) = state
  output = ((clkOut, cs, mosi), (ConnStd dataOut nextOutput busyOut))
  
main clk rst input (dataSize, delay) = moore clk rst (ctrl (dataSize, delay)) ctrlOut (0, 1, (0, high), low, 0, low, low, low, Init) input

getInfo = print "<empty>"