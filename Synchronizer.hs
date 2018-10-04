module Synchronizer where
import Clash.Explicit.Prelude
import SyncSafeMult
import SyncSafe
import ConnectorsStd

synchronizer :: KnownNat a => Clock domA Source -> Reset domA Asynchronous -> Clock domB Source -> Reset domB Asynchronous -> (Integer, Integer) -> (Signal domA (ConnStd a), Signal domB (ConnStd a)) -> (Signal domA (ConnStd a), Signal domB (ConnStd a))
synchronizer clkA rstA clkB rstB (freqIn, freqOut) (domAIn, domBIn) = (domAOut, domBOut)
  where
    ((div, mod), highToLow) = case freqIn > freqOut of
      True -> (freqIn `divMod` freqOut, True)
      False -> (freqOut `divMod` freqIn, False)
    multiple = (mod == 0)
    div' = fromInteger div :: Unsigned 32
    (domAOut, domBOut) = case multiple of
      True -> case (div' == 1) of
        True -> ((unsafeSynchronizer clkB clkA domBIn),(unsafeSynchronizer clkA clkB domAIn))
        False -> syncSafeMult clkA rstA clkB rstB div' (domAIn, domBIn)
      False -> syncSafe clkA rstA clkB rstB (domAIn, domBIn)