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

memory mem (select, input) = (mem', output)
  where
    output = case select of
      True -> input
      False -> mem
    mem' = output

outputState = mealy clkSlow resetSlow memory 0
inputState = mealy clkFast resetFast memory 0

constant_0_2 = pure False :: Signal DomainSlow Bool

constant_0 = pure False :: Signal DomainFast Bool
constant_1 = pure True :: Signal DomainFast Bool

topEntity :: Clock DomainFast Source -> Clock DomainSlow Source -> Signal DomainFast Bool -> Signal DomainFast (Unsigned 8) -> (Signal DomainSlow Bool, Signal DomainFast Bool, Signal DomainSlow (Unsigned 8))
topEntity clkA clkB signal message = (sig_sync, busy, message')
 where
   a1_d# = mux a3_q constant_0 a1_q
   a1_d = mux in_sel constant_1 a1_d#
   in_sel = signal .&&. (busy .==. constant_0)
   a3_q = dualFlipFlop2 clkB clkA b2_q
   b2_q = dualFlipFlop clkA clkB a1_q
   a1_q = register clkA resetFast False a1_d
   b3_q = register clkB resetSlow False b2_q
   sig_sync = b2_q .&&. ((b3_q) .==. constant_0_2)
   busy = a3_q .||. a1_q
   m1_q = inputState (bundle (in_sel, message))
   message' = outputState (bundle (b2_q, unsafeSynchronizer clkFast clkSlow m1_q))

testobject :: Signal DomainFast (Bool, (Unsigned 8)) -> Signal DomainFast (Bool, Bool, (Unsigned 8))
testobject input = bundle (sig_sync, busy, message')
  where
    (input#, message#) = unbundle (input)
    (sig_sync_, busy_, message_) = topEntity clkFast clkSlow input# message#
    sig_sync = unsafeSynchronizer clkSlow clkFast sig_sync_
    busy = busy_
    message' = unsafeSynchronizer clkSlow clkFast message_