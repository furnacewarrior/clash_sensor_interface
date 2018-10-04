module Synchronizer where
import Clash.Explicit.Prelude
import Clash.Signal (mux)

type DomainSlow = Dom "slow" 10000
type DomainFast = Dom "fast" 9000

clkFast :: Clock DomainFast Source
clkFast = clockGen

clkSlow :: Clock DomainSlow Source
clkSlow = clockGen

resetFast :: Reset DomainFast Asynchronous
resetFast = asyncResetGen

resetSlow :: Reset DomainSlow Asynchronous
resetSlow = asyncResetGen

dualFlipFlop :: Clock DomainFast Source -> Clock DomainSlow Source -> Signal DomainFast Bool -> Signal DomainSlow Bool
dualFlipFlop clkA clkB = register clkB resetSlow False . register clkB resetSlow False . unsafeSynchronizer clkA clkB

dualFlipFlop2 :: Clock DomainSlow Source -> Clock DomainFast Source -> Signal DomainSlow Bool -> Signal DomainFast Bool
dualFlipFlop2 clkA clkB = register clkB resetFast False . register clkB resetFast False . unsafeSynchronizer clkA clkB


constant_1_2 = pure True :: Signal DomainSlow Bool

constant_0 = pure False :: Signal DomainFast Bool
constant_1 = pure True :: Signal DomainFast Bool

topEntity :: Clock DomainFast Source -> Clock DomainSlow Source -> Signal DomainFast Bool -> (Signal DomainSlow Bool, Signal DomainFast Bool)
topEntity clkA clkB signal = (sig_sync, busy)
 where
   a1_d# = mux a3_q constant_0 a1_q
   a1_d = mux signal constant_1 a1_d#
   a3_q = dualFlipFlop2 clkB clkA b2_q
   b2_q = dualFlipFlop clkA clkB a1_q
   a1_q = register clkA resetFast False a1_d
   b3_q = register clkB resetSlow False b2_q
   sig_sync = b2_q .&&. ((b3_q) .&&. constant_1_2)
   busy = a3_q .||. a1_q

testobject :: Signal DomainFast Bool -> Signal DomainFast (Bool, Bool)
testobject input = bundle (sig_sync, busy)
  where
    (sig_sync_, busy_) = topEntity clkFast clkSlow input
    sig_sync = unsafeSynchronizer clkSlow clkFast sig_sync_
    busy = busy_