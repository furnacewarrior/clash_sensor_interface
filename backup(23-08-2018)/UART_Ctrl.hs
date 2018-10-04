module UART_Ctrl where
import Clash.Explicit.Prelude

shiftBV bv1 bit = (bvNext')
  where
    (bvNext, bvOut) = shiftInAtN (bv2v bv1) (singleton bit)
    bvNext' = v2bv bvNext

shiftRegOut :: (Unsigned 2, BitVector 8, Unsigned 3, Bit, Bit, Bit) -> (BitVector 8, Bit) -> ((Unsigned 2, BitVector 8, Unsigned 3, Bit, Bit, Bit), (Bit, Bit))
shiftRegOut state input = (state', output)
  where
    (dataIn, dataFlag) = input
    (stateInt, memory, counter, parity, tx, busy) = state
    (stateInt', memory', counter', parity', tx', busy') = case stateInt of
      0 -> case dataFlag==high of
        True -> (1, dataIn, 0, low, low, high)
        False -> (0, memory, 0, low, high, low)
      1 -> (2, shiftL memory 1, 0, low, head (bv2v memory), high)
      2 -> case counter of
        7 -> (3, memory, 0, low, parity, high)
        otherwise -> (2, shiftL memory 1, counter + 1, xor tx parity ,head (bv2v memory), high)
      3 -> (0, memory, 0, low, high, high)
    state' = (stateInt', memory', counter', parity', tx', busy')
    output = (tx, busy)

shiftRegOut# clk rst = mealy clk rst shiftRegOut (0, 0, 0, low, high, low)

shiftRegIn :: (Unsigned 2, BitVector 8, Unsigned 3, Bit, BitVector 8, Bit, Bit, Bit) -> Bit -> ((Unsigned 2, BitVector 8, Unsigned 3, Bit, BitVector 8, Bit, Bit, Bit), (BitVector 8, Bit, Bit, Bit))
shiftRegIn state input = (state', output)
  where
    (rx) = input
    (stateInt, memory, counter, parity, dataOut, dataFlag, parityFlag, phaseFreeFlag) = state
    (stateInt', memory', counter', parity', dataOut', dataFlag', parityFlag', phaseFreeFlag') = case stateInt of
      0 -> case rx==low of
        True -> (1, memory, 0, low, dataOut, low, low, low)
        False -> (0, memory, counter, low, dataOut, low, low, high)
      1 -> case counter of
        7 -> (2, shiftBV memory rx, 0, xor rx parity, dataOut, low, low, low)
        otherwise -> (1, shiftBV memory rx, counter + 1, xor rx parity , dataOut, low, low, low)
      2 -> case parity == rx of
        True -> (0, memory, 0, parity, memory, high, low, low)
        False -> (0, memory, 0, parity, dataOut, low, high, low) 
    state' = (stateInt', memory', counter', parity', dataOut', dataFlag', parityFlag', phaseFreeFlag')
    output = (dataOut, dataFlag, parityFlag, phaseFreeFlag)

shiftRegIn# clk rst = mealy clk rst shiftRegIn (0, 0, 0, low, 0, low, low, low)

edgeDetect :: Bit -> Bit -> (Bit, Bit)
edgeDetect state input = (state', output)
  where
    rx = input
    rxPrev = state
    rxPrev' = (rx)
    state' = rxPrev'
    output = boolToBit ((rxPrev == high) && (rx == low))

edgeDetect# clk rst = mealy clk rst edgeDetect low


baudGen :: (Unsigned 8, Bit) -> (Bit, Bit, Unsigned 8) -> ((Unsigned 8, Bit), Bit)
baudGen state input = (state', output)
  where
    (phase, phaseFree, divider) = input
    (counter, clkBaud) = state
    (counter', clkBaud') = case phase==high && phaseFree==high of
      True -> (0, low)
      False -> case counter < divider of
        True -> (0, complement clkBaud)
        False -> (counter + 1, clkBaud)
    state' = (counter', clkBaud')
    output = clkBaud

baudGen# clk rst = mealy clk rst baudGen (0, low)

type DomainBaud = Dom "baud" 4000

interfaceUART clk rst input = output
  where
    clkBaud = clockGen :: Clock DomainBaud Source
    rstBaud = asyncResetGen :: Reset DomainBaud Asynchronous
    (dataIn, dataInFlag, rx) = unbundle (input)
    (tx, busy) = unbundle (shiftRegOut# clkBaud rstBaud (bundle ((unsafeSynchronizer clk clkBaud dataIn), (unsafeSynchronizer clk clkBaud dataInFlag))))
    (dataOut, dataOutFlag, parityError, phaseFreeFlag) = unbundle (shiftRegIn# clkBaud rstBaud (unsafeSynchronizer clk clkBaud rx))
    parity = unbundle (edgeDetect# clk rst rx)
    clkBaud_ = baudGen# clk rst (bundle (parity, (unsafeSynchronizer clkBaud clk phaseFreeFlag), 7))
    output = unsafeSynchronizer clkBaud clk (bundle (dataOut, dataOutFlag, parityError, busy, tx))

type DomainA = Dom "fast" 2000

testobject :: Signal DomainA (BitVector 8, Bit, Bit) -> Signal DomainA (BitVector 8, Bit, Bit, Bit, Bit)
testobject input = interfaceUART clkA rstA input
  where
    clkA = clockGen :: Clock DomainA Source
    rstA = asyncResetGen :: Reset DomainA Asynchronous

testInputs = [(5, low, high), (5, high, high), 
              (5, low, low), (5, low, low), 
              (5, low, high), (5, low, high), 
              (5, low, low), (5, low, low), 
              (5, low, high), (5, low, high), 
              (5, low, low) , (5, low, low), 
              (5, low, high), (5, low, high), 
              (5, low, high), (5, low, high),
              (5, low, high), (5, low, high),
              (5, low, high), (5, low, high),
              (5, low, low), (5, low, low),
              (5, low, high), (5, low, high)]