module TestMachine where
import Clash.Explicit.Prelude

type State = (BitVector 8, Unsigned 3)

shiftBitInOut :: KnownNat a => BitVector a -> Bit -> (BitVector a, Bit)
shiftBitInOut vector bit = (bvNext', bvOut')
  where
    bvNext = shiftL vector 1
    bvNext' = replaceBit 0 bit bvNext
    bvOut' = msb vector

testMachine :: State -> BitVector 8 -> State
testMachine state input = state'
  where
    input' = input
    (outputValue, stateL) = state

    (outputValue', bitOut) = shiftBitInOut outputValue low    
    newState = case stateL of
      0 -> 1
      1 -> 2
      2 -> 3
      3 -> 4
      4 -> 0

    state' = case (newState) of
      0 -> (outputValue', newState)
      1 -> (outputValue', newState)
      2 -> (outputValue', newState)
      3 -> (outputValue', newState)
      4 -> (input, newState)

testMachineOut :: State -> BitVector 8 
testMachineOut state = output
  where
    (outputValue, stateL) = state
    output = outputValue

{-# ANN topEntity
   (Synthesize
      { t_name   = "TestMachine"
      , t_inputs = [ PortName "clk", 
                     PortName "rst",
                     PortName "dataIn"]
      , t_output = PortName "dataOut"}) #-}
topEntity
  :: Clock DomainUser Source 
  -> Reset DomainUser Asynchronous 
  -> Signal DomainUser (BitVector 8)
  -> Signal DomainUser (BitVector 8)
topEntity clk rst input = moore clk rst testMachine testMachineOut (0,0) input

type DomainUser = Dom "user" 9000

{-# ANN topEntity (TestBench 'testBench) #-}
testBench
  :: Signal DomainUser (BitVector 8)
testBench = output
  where
    testInput      = stimuliGenerator clk rst $(listToVecTH [11::(BitVector 8),20,30,10,210,21,23])
    output = topEntity clk rst testInput
    done'        = pure False
    clk          = tbClockGen @DomainUser done'
    rst          = asyncResetGen @DomainUser 