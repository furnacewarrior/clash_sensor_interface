module Synchronizer where
import Clash.Explicit.Prelude
import Clash.Signal (mux)

type DomainSlow = Dom "slow" 10000
type DomainFast = Dom "fast" 9000

clkSlow :: Clock DomainSlow Source
clkSlow = clockGen

resetSlow :: Reset DomainSlow Asynchronous
resetSlow = asyncResetGen

memory mem (select, input) = (mem', output)
  where
    output = case select of
      True -> input
      False -> mem
    mem' = output

outputState = mealy clkSlow resetSlow memory 0