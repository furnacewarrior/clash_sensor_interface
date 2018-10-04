module Sync_without_feedback where
import Clash.Explicit.Prelude
import Clash.Signal (mux)

type DomainIn = Dom "input" 10000
type DomainOut = Dom "output" 9000

dualFlipFlop rst clkA clkB = register clkB rst False . register clkB rst False . unsafeSynchronizer clkA clkB


memory mem (select, input) = (mem', output)
  where
    output = case select of
      True -> input
      False -> mem
    mem' = output

selectBuffer clk rst = mealy clk rst memory 0

topEntity :: Clock DomainIn Source -> Reset DomainIn Asynchronous -> Clock DomainOut Source -> Reset DomainOut Asynchronous -> Signal DomainIn Bool -> Signal DomainIn (Unsigned 8) -> (Signal DomainOut Bool, Signal DomainOut (Unsigned 8))
topEntity clkA rstA clkB rstB signal message = (sig_sync, message')
 where
   a1_q = register clkA rstA False signal
   b2_q = dualFlipFlop rstB clkA clkB a1_q
   b3_q = register clkB rstB False b2_q
   sig_sync = b2_q .&&. ((b3_q) .==. (pure False))
   m1_q = register clkA rstA 0 message
   message' = selectBuffer clkB rstB (bundle (b2_q, unsafeSynchronizer clkA clkB m1_q))

testobject :: Signal DomainIn (Bool, (Unsigned 8)) -> Signal DomainOut (Bool, (Unsigned 8))
testobject input = bundle (sig_sync, message')
  where
    (input#, message#) = unbundle (input)
    (sig_sync_, message_) = topEntity clockGen asyncResetGen clockGen asyncResetGen input# message#
    sig_sync = sig_sync_
    message' = message_