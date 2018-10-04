module Sync_with_feedback where
import Clash.Explicit.Prelude
import Clash.Signal (mux)

type DomainOut = Dom "slow" 8191
type DomainIn = Dom "fast" 4095

dualFlipFlop rst clkA clkB = register clkB rst False . register clkB rst False . unsafeSynchronizer clkA clkB

memory mem (select, input) = (mem', output)
  where
    output = case select of
      True -> input
      False -> mem
    mem' = output

selectBuffer clk rst = mealy clk rst memory 0

topEntity :: Clock DomainIn Source -> Reset DomainIn Asynchronous -> Clock DomainOut Source -> Reset DomainOut Asynchronous -> Signal DomainIn Bool -> Signal DomainIn (Unsigned 8) -> (Signal DomainOut Bool, Signal DomainIn Bool, Signal DomainOut (Unsigned 8))
topEntity clkA rstA clkB rstB signal message = (sig_sync, busy, message')
 where
   a1_d# = mux a3_q (pure False) a1_q
   a1_d = mux in_sel (pure True) a1_d#
   in_sel = signal .&&. (busy .==. (pure False))
   a3_q = dualFlipFlop rstA clkB clkA b2_q
   b2_q = dualFlipFlop rstB clkA clkB a1_q
   a1_q = register clkA rstA False a1_d
   b3_q = register clkB rstB False b2_q
   sig_sync = b2_q .&&. ((b3_q) .==. (pure False))
   busy = a3_q .||. a1_q
   m1_q = selectBuffer clkA rstA (bundle (in_sel, message))
   message' = selectBuffer clkB rstB (bundle (b2_q, unsafeSynchronizer clkA clkB m1_q))

testobject :: Signal DomainIn (Bool, (Unsigned 8)) -> Signal DomainIn (Bool, Bool, (Unsigned 8))
testobject input = bundle (sig_sync, busy, message')
  where
    clkA = clockGen
    clkB = clockGen
    (input#, message#) = unbundle (input) 
    (sig_sync_, busy_, message_) = topEntity clkA asyncResetGen clkB asyncResetGen input# message#
    sig_sync = unsafeSynchronizer clkB clkA sig_sync_
    busy = busy_
    message' = unsafeSynchronizer clkB clkA message_