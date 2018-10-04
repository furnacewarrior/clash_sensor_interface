module Connectors_Sync where
import Clash.Explicit.Prelude

data DataSync a = DataSync {data# :: BitVector a, sync# :: Bit}

data Busy = Busy {busy# :: Bit}