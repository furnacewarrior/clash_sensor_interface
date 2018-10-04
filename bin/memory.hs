module Memory where
import CLaSH.Prelude

ram = repeat 0 :: Vec 255 (Signed 8)
initial = repeat 0 :: Vec 255 (Signed 8)

memory mem (addr, read, write, value) = (mem', output)
  where
    mem' = case read of
      True  -> mem
      False -> case write of
        True -> replace addr value mem
        False -> mem
    output = case read of
      True  -> mem !! addr
      False -> 0

memBlock = mealy memory initial

topEntity :: Signal (Unsigned 8, Bool, Bool, Signed 8) -> Signal (Signed 8)
topEntity = memBlock