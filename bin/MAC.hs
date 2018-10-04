module MAC where
import CLaSH.Prelude

mac acc (val1,val2) = acc + val1 * val2 


topEntity :: Signed 16 -> (Signed 16, Signed 16) -> Signed 16
topEntity = mac