module Multiplier where
import CLaSH.Prelude

multiplier val1 val2 = val1 * val2 


topEntity :: Signed 16 -> Signed 16 -> Signed 16
topEntity = multiplier