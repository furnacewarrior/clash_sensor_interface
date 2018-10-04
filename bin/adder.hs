module Adder where
import CLaSH.Prelude

adder val1 val2 sub = case sub of
  True -> val1 - val2
  False -> val1 + val2

topEntity :: Signed 16 -> Signed 16 -> Bool -> Signed 16
topEntity = adder