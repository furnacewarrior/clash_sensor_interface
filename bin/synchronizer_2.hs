module Synchronizer where
import Clash.Explicit.Prelude
import Clash.Signal (mux)

type DomainSlow = Dom "user" 10000
type DomainFast = Dom "sensor" 9000

clkFast :: Clock DomainFast Source
clkFast = clockGen

clkSlow :: Clock DomainSlow Source
clkSlow = clockGen

reset :: Reset DomainSlow Asynchronous
reset = asyncResetGen

reset2 :: Reset DomainFast Asynchronous
reset2 = asyncResetGen

dualFlipFlop :: Clock DomainFast Source -> Clock DomainSlow Source -> Signal DomainFast Bool -> Signal DomainSlow Bool
dualFlipFlop clkA clkB = register clkB reset False . register clkB reset False . unsafeSynchronizer clkA clkB

dualFlipFlop2 :: Clock DomainSlow Source -> Clock DomainFast Source -> Signal DomainSlow Bool -> Signal DomainFast Bool
dualFlipFlop2 clkA clkB = register clkB reset2 False . register clkB reset2 False . unsafeSynchronizer clkA clkB

constant_0 = pure False :: Signal DomainFast Bool
constant_1 = pure True :: Signal DomainFast Bool

constant_1_2 = pure True :: Signal DomainSlow Bool

topEntity :: Clock DomainFast Source -> Clock DomainSlow Source -> Signal DomainFast Bool ->  (Signal DomainFast Bool, Signal DomainSlow Bool)
topEntity clkA clkB signal = (busy, sig_sync)
 where
   a1_d# = mux a3_q constant_0 a1_q
   a1_d = mux signal constant_1 a1_d#
   a3_q = dualFlipFlop2 clkB clkA b2_q
   b2_q = dualFlipFlop clkA clkB a1_q
   a1_q = register clkA reset2 False a1_d
   b3_q = register clkB reset False b2_q
   sig_sync = b2_q .&&. ((b3_q) .&&. constant_1_2)
   busy = a3_q .&&. a1_q
  
  