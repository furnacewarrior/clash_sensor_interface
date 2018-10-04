module Connectors where
import Clash.Explicit.Prelude
 
data I_SPI_In = Full_In {_finished :: Bit, _dataIn :: (BitVector 8)} |
                NoData_In {_finished :: Bit}
data I_SPI_Out = Full_Out {nextOutput :: Bit, nextByte :: Bit, dataOut :: (BitVector 8)}

data D_Sync = D_Sync {sync :: Bit, message :: (BitVector 8)}