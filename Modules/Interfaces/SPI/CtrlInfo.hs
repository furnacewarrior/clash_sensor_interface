module Modules.Interfaces.SPI.CtrlInfo where
import Clash.Explicit.Prelude
import qualified Data.List as L
import qualified Modules.Interfaces.SPI.Ctrl as SPI

getInfo = putStr x
  where
    x = "-------------------------------------------------------------------------------\n\
    \                               SPI controller                                  \n\
    \-------------------------------------------------------------------------------\n\
    \Converts spi interface to parallel input and output                            \n\
	\                                                                               \n\
	\                   +------------+                                              \n\
	\clk            --> |    Spi     | --> cs                                       \n\
    \rst            --> | Controller | --> mosi                                     \n\
	\driverOut(a)   --> |            | <-- miso                                     \n\
	\driverIn(a)    <-- |            | --> clkOut                                   \n\
	\                   +------------+                                              \n\
	\ Settings                                                                      \n\
    \ dataSize: indicates the size of the messages send and read                    \n\
	\           => <Size - 1> :: (Unsigned <ceil(log2(Size))>)                      \n\
    \ SPIType: Type of controller                                                   \n\
    \  -> Std :: standard controller with writes when NewByte input signal goes high\n\
    \  -> Stream :: reads messages after eachother without making CS high in between\n\
    \  -> StreamR :: reads messages after eachother, CS goes high after each message\n\
	\-------------------------------------------------------------------------------\n"

getVersion = putStr output
  where
    output = a L.++ b L.++ c L.++ d
    a = "SPI Ctrl: v" L.++ SPI.version L.++ "\n"
    b = "std: v" L.++ SPI.version L.++ "\n"
    c = "stream: v" L.++ SPI.version L.++ "\n"
    d = "streamR: v" L.++ SPI.version L.++ "\n"
