module ClashTest where
import Clash.Explicit.Prelude

type DomainA = Dom "dom1" 9000
type DomainB = Dom "dom2" 4500

calc :: Unsigned 8 -> (Unsigned 8, Unsigned 8, Bool) -> (Unsigned 8, Unsigned 8)
calc state input = (state', output)
  where
    (a, b, d) = input
    c = state
    c' = case d of
      True -> a * b
      False -> a + b
    state' = c'
    output = c

ctrl clk rst = mealy clk rst calc 0

topEntity :: Clock DomainA Source -> Reset DomainA Asynchronous -> Signal DomainA (Unsigned 8) -> Signal DomainA (Unsigned 8) -> Signal DomainA (Unsigned 8)
topEntity clk rst a b = ctrl clk rst (bundle (a, b, pure True))

clkConvert :: Clock DomainA Source  -> Clock DomainB Source 
clkConvert clk = (clk / 2)