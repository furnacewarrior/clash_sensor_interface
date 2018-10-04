module Sync_unsafe where
import Clash.Explicit.Prelude
import Clash.Signal (mux)
import Connectors_Sync

--	Synchronizes signal from clock domain A to clock domain B
--	
--				+------------+
--	clkA	-->	|Synchronizer| <--	clkB
--	rstA	-->	|			 | <--	rstB
--	message	-->	|			 | -->	message'
--	sync	-->	|			 | -->	sync'
--				+------------+

dualFlipFlop rst clk = register clk rst False . register clk rst False

sync_unsafe :: KnownNat a => Clock domA Source -> Reset domA Asynchronous -> Clock domB Source -> Reset domB Asynchronous -> (Signal domA (DataSync a), Signal domB Busy) -> (Signal domB (DataSync a), Signal domA Busy)
sync_unsafe clkA rstA clkB rstB (dataIn, busyIn) = output
  where
    message = data#<$>dataIn
    sync = sync#<$>dataIn
    busy = busy#<$>busyIn
    message' = regEn clkA rstA 0 (bitToBool<$>sync) message
    sync' = register clkA rstA False (bitToBool<$>sync)
    sync'' = dualFlipFlop rstB clkB (unsafeSynchronizer clkA clkB sync')
    sync''' = register clkB rstB False sync''
    sync'''' = (not<$>sync''') .&&. sync''
    messageOut = regEn clkB rstB 0 sync'' (unsafeSynchronizer clkA clkB message')
    syncOut = boolToBit<$>(register clkB rstB False sync'''')
    busyOut = unsafeSynchronizer clkB clkA busy
    output = (DataSync<$>messageOut<*>syncOut, Busy<$>busyOut)

{-
type DomainOut = Dom "slow" 9000
type DomainIn = Dom "fast" 9000

testobject :: Signal DomainIn ((BitVector 8), Bit) -> Signal DomainOut ((BitVector 8), Bit)
testobject input = bundle (dataOut', sync')
  where
    clkA = clockGen :: Clock DomainIn Source
    rstA = asyncResetGen :: Reset DomainIn Asynchronous
    clkB = clockGen :: Clock DomainOut Source
    rstB = asyncResetGen :: Reset DomainOut Asynchronous
    (dataIn, syncIn) = unbundle (input) 
    (dataOut, busyOut) = sync_unsafe clkA rstA clkB rstB (DataSync<$>dataIn<*>syncIn, Busy<$>(pure low))
    dataOut' = data#<$>dataOut
    sync' = sync#<$>dataOut

testInputs = [(4, low), (4, low),(2, high),(2, low),(2, low),(2, low),(8, high),(4, low),(1, low),(4, low),(5, high),(4, low),(4, low),(4, low),(4, low),(4, low),(4, low)]
-}