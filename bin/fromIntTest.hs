module FromIntTest where
import CLaSH.Prelude

test value = fromIntegral value

topEntity :: Signal Signed 4 -> Signal BitVector 16
topEntity value = test value