module TestTypes where
import Clash.Explicit.Prelude
import ConnectorsStd

type DomainUser = Dom "user" 9000

testobject :: ConnStd 8 -> ConnStd 8 -> ConnStd 8
testobject state input = state'
  where
    newDataIn = data# input
    newByte = newByte# input
    newBusy = busy# input

    oldDataIn = data# state
    oldByte = newByte# state
    oldBusy = busy# state

    state' = ConnStd newDataIn oldByte oldBusy

testobjectOut :: ConnStd 8 -> BitVector 8
testobjectOut state = output
  where
    output = data# state

main clk rst input = moore clk rst testobject testobjectOut (ConnStd 0 low low) input

{-# ANN topEntity
   (Synthesize
      { t_name   = "test"
      , t_inputs = [ PortName "clk", 
                     PortName "rst",
                     PortName "sigIn"]
      , t_output = PortName "sigOut" }) #-}
topEntity
  :: Clock DomainUser Source 
  -> Reset DomainUser Asynchronous 
  -> Signal DomainUser (ConnStd 8)
  -> Signal DomainUser (BitVector 8)
topEntity clk rst input = main clk rst input
{-# NOINLINE topEntity #-}

{-# ANN topEntity (TestBench 'testBench) #-}
testBench
  :: Signal DomainUser (BitVector 8)
testBench = output
  where
    testInput      = stimuliGenerator clk rst $(listToVecTH [11::(BitVector 8), 10, 9, 8, 7, 6, 5, 4, 3, 2, 1])
    input = (ConnStd<$>testInput<*>(pure low)<*>(pure low))
    output = topEntity clk rst input
    done'        = pure True
    clk          = tbClockGen @DomainUser done'
    rst          = asyncResetGen @DomainUser 