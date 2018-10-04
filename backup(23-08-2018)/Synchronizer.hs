module Synchronizer where
import Clash.Explicit.Prelude
import SyncSafeMult
import Sync_unsafe
import Sync_safe
import Connectors_Sync

synchronizer :: KnownNat a => Clock domA Source -> Reset domA Asynchronous -> Clock domB Source -> Reset domB Asynchronous -> (Integer, Integer) -> (Signal domA (DataSync a), Signal domB Busy) -> (Signal domB (DataSync a), Signal domA Busy)
synchronizer clkA rstA clkB rstB (freqIn, freqOut) (dataIn, busyIn) = (dataOut, busyOut)
  where
    ((div, mod), highToLow) = case freqIn > freqOut of
      True -> (freqIn `divMod` freqOut, True)
      False -> (freqOut `divMod` freqIn, False)
    multiple = (mod == 0)
    div' = fromInteger div :: Unsigned 32
    (dataOut, busyOut) = case highToLow of
      True -> case multiple of
        True -> syncSafeMult clkA rstA clkB rstB div' (dataIn, busyIn)
        False -> sync_safe clkA rstA clkB rstB (dataIn, busyIn)
      False -> case multiple of
        True -> (unsafeSynchronizer clkA clkB dataIn, unsafeSynchronizer clkB clkA busyIn)
        False -> sync_unsafe clkA rstA clkB rstB (dataIn, busyIn)