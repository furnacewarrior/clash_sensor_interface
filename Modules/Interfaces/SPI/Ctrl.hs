module Modules.Interfaces.SPI.Ctrl(main, SPIType(Std, Stream, StreamR), version) where
import Clash.Explicit.Prelude
import qualified Modules.Interfaces.SPI.Designs.Std as SPI_std
import qualified Modules.Interfaces.SPI.Designs.Stream as SPI_stream
import qualified Modules.Interfaces.SPI.Designs.StreamR as SPI_streamR
import qualified Modules.Interfaces.SPI.Designs.StreamDelay as SPI_streamDelay
import qualified Modules.Interfaces.SPI.Designs.StreamRDelay as SPI_streamRDelay
import ConnectorsStd

{-	Spi controller, converts spi interface to parallel input and output
-----------------------------------------------------------------------	
					+------------+
	clk			--> |	 Spi	 | -->	cs
	rst			-->	| Controller | -->	mosi
	driverOut(a)-->	|			 | <--	miso
	driverIn(a)	<--	|			 | -->	clkOut
					+------------+

	Settings
      dataSize: indicates the size of the messages send and read => <Size - 1> :: (Unsigned <ceil(log2(Size))>)
      SPIType: Type of controller
       |Std :: standard controller with writes when NewByte input signal goes high
       |Stream :: reads messages after eachother without making CS high in between
       |StreamR :: reads messages after eachother but CS goes high after each message
-----------------------------------------------------------------------
 -}

version = "1.0"

data SPIType a b = Std a | StreamR a b | Stream a b

main 
  :: (KnownNat a) 
  => Clock domain Source 
  -> Reset domain Asynchronous 
  -> Signal domain (ConnStd a, Bit)  
  -> SPIType (Unsigned 16) (Unsigned 16)
  -> (Signal domain (Bit, Bit), Signal domain (ConnStd a), Clock domain Gated)

main clk rst input (Std dataSize) = spiGen clk rst input dataSize SPI_std.main
main clk rst input (StreamR dataSize delay) = ctrl
  where
    ctrl = case (delay == 0) of
      True -> spiGen clk rst input dataSize SPI_streamR.main
      False -> spiGen clk rst input (dataSize, delay) SPI_streamRDelay.main
main clk rst input (Stream dataSize delay) = ctrl
  where
    ctrl = case (delay == 0) of
      True -> spiGen clk rst input dataSize SPI_stream.main
      False -> spiGen clk rst input (dataSize, delay) SPI_streamDelay.main

spiGen clk rst input dataSize spiMoore = output
  where
  (sensorIn, driverIn') = unbundle (spiMoore clk rst input (dataSize))
  (clkOut, cs, mosi) = unbundle (sensorIn)
  clkOut' = clockGate clk (bitToBool<$>clkOut)
  sensorIn' = bundle (cs, mosi)
  output = (sensorIn', driverIn', clkOut')