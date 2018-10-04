module Connectors_SPI where
import Clash.Explicit.Prelude

data SPI_Ctrl_in a = 
  SPI_Ctrl_in { dataIn# :: BitVector a, finished# :: Bit, busy# :: Bit} |
  SPI_Ctrl_in_noData {finished# :: Bit, busy# :: Bit} |
  SPI_Ctrl_in_noBusy { dataIn# :: BitVector a, finished# :: Bit} |
  SPI_Ctrl_in_noData_noBusy {finished# :: Bit}
  
data SPI_Ctrl_out a = 
  SPI_Ctrl_out { dataOut# :: BitVector a, newByte# :: Bit} |
  SPI_Ctrl_out_noData {newByte# :: Bit}