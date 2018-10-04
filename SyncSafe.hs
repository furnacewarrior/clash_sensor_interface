module SyncSafe where
import Clash.Explicit.Prelude
import ConnectorsStd
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

sync_safe :: KnownNat a => Clock domA Source -> Reset domA Asynchronous -> Clock domB Source -> Reset domB Asynchronous -> (Signal domA (BitVector a), Signal domA Bit, Signal domB Bit) -> (Signal domB (BitVector a), Signal domB Bit, Signal domA Bit)
sync_safe clkA rstA clkB rstB (message, sync, busy) = output
  where
    busy' = register clkB rstB low busy
    syncEn = (bitToBool<$>sync) .&&. (not<$>busyOut)
    message' = regEn clkA rstA 0 syncEn message
    syncIn = mux syncEn (pure True) (mux feedback (pure False) sync')
    sync' = register clkA rstA False syncIn
    busyOut = feedback .||. sync'
    feedback = dualFlipFlop rstA clkA (unsafeSynchronizer clkB clkA feedback')
    messageOut = regEn clkB rstB 0 syncEn' (unsafeSynchronizer clkA clkB message')
    syncEn' = dualFlipFlop rstB clkB (unsafeSynchronizer clkA clkB sync')
    feedback' = mux (bitToBool<$>busy') (pure True) syncEn'
    sync'' = register clkB rstB False syncEn'
    sync''' = (not<$>sync'') .&&. syncEn'
    syncOut = boolToBit<$>(register clkB rstB False sync''')
    output = (messageOut, syncOut, (boolToBit<$>busyOut))

syncSafe :: KnownNat a => Clock domA Source -> Reset domA Asynchronous -> Clock domB Source -> Reset domB Asynchronous -> (Signal domA (ConnStd a), Signal domB (ConnStd a)) -> (Signal domA (ConnStd a), Signal domB (ConnStd a))
syncSafe clkA rstA clkB rstB (domAIn, domBIn) = (domAOut, domBOut)
  where
    dataInA = data#<$>domAIn
    syncA = newByte#<$>domAIn
    busyA = busy#<$>domAIn

    dataInB = data#<$>domBIn
    syncB = newByte#<$>domBIn
    busyB = busy#<$>domBIn

    (dataOutB, syncOutB, busyOutA) = sync_safe clkA rstA clkB rstB (dataInA, syncA, busyB)
    (dataOutA, syncOutA, busyOutB) = sync_safe clkB rstB clkA rstA (dataInB, syncB, busyA)

    domAOut = ConnStd<$>dataOutA<*>syncOutA<*>busyOutA
    domBOut = ConnStd<$>dataOutB<*>syncOutB<*>busyOutB


--Test input
type DomainOut = Dom "slow" 9000
type DomainIn = Dom "fast" 9000

testobject :: Signal DomainIn ((BitVector 8), Bit) -> Signal DomainOut ((BitVector 8), Bit)
testobject input = bundle (dataOut, sync)
  where
    clkA = clockGen :: Clock DomainIn Source
    rstA = asyncResetGen :: Reset DomainIn Asynchronous
    clkB = clockGen :: Clock DomainOut Source
    rstB = asyncResetGen :: Reset DomainOut Asynchronous

    (dataIn, syncIn) = unbundle (input) 
    (domAOut, domBOut) = syncSafe clkA rstA clkB rstB (ConnStd<$>dataIn<*>syncIn<*>(pure low), ConnStd<$>(pure 0)<*>(pure low)<*>(pure low))
    dataOut = data#<$>domBOut
    sync = newByte#<$>domBOut

testInputs = [(4, low), (4, low),(2, high),(2, low),(2, low),(2, low),(8, high),(4, low),(1, low),(4, low),(5, high),(4, low),(4, low),(4, low),(4, low),(4, low),(4, low)]
