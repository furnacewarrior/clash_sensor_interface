module Sync_safe where
import Clash.Explicit.Prelude
import Connectors_Sync
import Clash.Signal (mux)

--	Synchronizes signal from clock domain A to clock domain B with handshake
--	
--				+------------+
--	clkA	-->	|Synchronizer| <--	clkB
--	rstA	-->	|			 | <--	rstB
--	message	-->	|			 | -->	message'
--	sync	-->	|			 | -->	sync'
--	busy	<--	|			 | <--  busy
--				+------------+



dualFlipFlop rst clk = register clk rst False . register clk rst False

sync_safe :: KnownNat a => Clock domA Source -> Reset domA Asynchronous -> Clock domB Source -> Reset domB Asynchronous -> (Signal domA (DataSync a), Signal domB Busy) -> (Signal domB (DataSync a), Signal domA Busy)
sync_safe clkA rstA clkB rstB (dataIn, busyIn) = output
  where
    message = data#<$>dataIn
    sync = sync#<$>dataIn
    busy = busy#<$>busyIn

    syncEn = (bitToBool<$>sync) .&&. (not<$>busyOut)
    message' = regEn clkA rstA 0 syncEn message
    syncIn = mux syncEn (pure True) (mux feedback (pure False) sync')
    sync' = register clkA rstA False syncIn
    busyOut = feedback .||. sync'
    feedback = dualFlipFlop rstA clkA (unsafeSynchronizer clkB clkA feedback')
    messageOut = regEn clkB rstB 0 syncEn' (unsafeSynchronizer clkA clkB message')
    syncEn' = dualFlipFlop rstB clkB (unsafeSynchronizer clkA clkB sync')
    feedback' = mux (bitToBool<$>busy) (pure True) syncEn'
    sync'' = register clkB rstB False syncEn'
    sync''' = (not<$>sync'') .&&. syncEn'
    syncOut = boolToBit<$>(register clkB rstB False sync''')
    output = (DataSync<$>messageOut<*>syncOut, Busy<$>(boolToBit<$>busyOut))

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
    (dataOut, busyOut) = sync_safe clkA rstA clkB rstB (DataSync<$>dataIn<*>syncIn, Busy<$>(pure low))
    dataOut' = data#<$>dataOut
    sync' = sync#<$>dataOut

testInputs = [(4, low), (4, low),(2, high),(2, low),(2, low),(2, low),(8, high),(4, low),(1, low),(4, low),(5, high),(4, low),(4, low),(4, low),(4, low),(4, low),(4, low)]
