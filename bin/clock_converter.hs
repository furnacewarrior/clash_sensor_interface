module Clock_converter where
import Clash.Explicit.Prelude

type DomainIn = Dom "fast" 9000

--converter :: (Bool, (Unsigned 8)) -> (Unsigned 8) -> ((Bool, (Unsigned 8)), Bool)
converter counter factor = (counter', output)
  where  
    (outputInt, counterInt) = (counter)
    action = ((counterInt) >= (factor))
    counter# = case (action) of
      True -> 0
      False -> (counterInt + 1)
    output = case (action) of
      True -> (outputInt == False)
      False -> outputInt
    counter' = (output, counter#)

resetValue = (False, 0) :: (Bool, (Unsigned 8))
clockConvert clk rst = mealy clk rst converter resetValue

topEntity:: Clock DomainIn Source -> Reset DomainIn Asynchronous -> Signal DomainIn (Unsigned 8) -> Signal DomainIn Bool
topEntity clk rst factor = clockConvert clk rst factor
