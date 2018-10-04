module SPI_Ctrl where
import Clash.Explicit.Prelude
import ClashAddon
import LightSensorModel
import Connectors_SPI

{-	Spi controller, converts spi interface to parallel input and output
-----------------------------------------------------------------------	
	clk			-->	+------------+
	rst			-->	|	 Spi	 | -->	cs
	dataIn(a)	-->	| Controller | -->	mosi
	dataOut(a)	<--	|			 | <--	miso
	nextOutput	<--	|			 | -->	clkOut
	finished	-->	+------------+

	Settings 
	-> dataSize: Size in bits of incomming and outgoing data
    -> hasOutput: If data needs to be collected from sensor	
-----------------------------------------------------------------------
 -}

spiCtrl :: (KnownNat a, KnownNat b, c ~ (Unsigned b, (BitVector a, Bit), Bit, BitVector a, Bit, Bit)) => (Unsigned b, Bool) -> c -> (SPI_Ctrl_in a, Bit) -> (c, ((Bit, Bit, Bit), SPI_Ctrl_out a))
spiCtrl (dataSize, hasOutput) state input = (state', output)
  where
    (input', miso) = input
    (dataIn, finished) = case input' of
      SPI_Ctrl_in a b -> (a, b)
      SPI_Ctrl_in_noData a -> (0, a)
    (counter, (buffer, mosi), cs, dataOut, nextOutput, clkOut) = state
    state' = case finished == high of
      True -> (dataSize, (buffer, low), high, dataOut, low, low)
      False -> case (counter == dataSize) of 
        True -> (0, shiftBitInOut dataIn miso, low, shiftBitIn buffer miso, high, high)
        False -> (counter + 1, shiftBitInOut buffer miso, low, dataOut, low, high)
    output = case hasOutput of
      True -> ((clkOut, cs, mosi), (SPI_Ctrl_out dataOut nextOutput))
      False -> ((clkOut, cs, mosi), (SPI_Ctrl_out_noData nextOutput))


spiCtrl' clk rst input (dataSize, hasOutput) = mealy clk rst (spiCtrl (dataSize, hasOutput)) (dataSize, (0, high), low, 0, low, low) input


spi_Ctrl:: (KnownNat a, KnownNat b) => Clock domain Source -> Reset domain Asynchronous -> Signal domain (SPI_Ctrl_in a, Bit) -> (Unsigned b, Bool) -> (Signal domain (Bit, Bit), Signal domain (SPI_Ctrl_out a), Clock domain Gated)
spi_Ctrl clk rst input (dataSize, hasOutput) = output
  where
  (sensorIn, driverIn') = unbundle (spiCtrl' clk rst input (dataSize, hasOutput))
  (clkOut, cs, mosi) = unbundle (sensorIn)
  clkOut' = clockGate clk (bitToBool<$>clkOut)
  sensorIn' = bundle (cs, mosi)
  output = (sensorIn', driverIn', clkOut')


spi_Ctrl_sim clk rst input (dataSize, hasOutput) = output
  where
    miso = lightSensorModel clkOut rst sensor
    (sensor, driver, clkOut) = spi_Ctrl clk rst (bundle (input, miso)) (dataSize, hasOutput)
    output = driver    

{-
--Test Code
type DomainUser = Dom "user" 9000

testobject :: Signal DomainUser (BitVector 8, Bit) -> Signal DomainUser (BitVector 8)
testobject input = message
  where
    clkA = clockGen :: Clock DomainUser Source
    rstA = asyncResetGen :: Reset DomainUser Asynchronous
    (dataIn, finished) = unbundle input
    message = dataOut#<$>(spi_Ctrl_sim clkA rstA ((SPI_Ctrl_in<$>dataIn<*>finished)) ((7 :: Unsigned 3), True))

testInputs = [((11, high)), ((11, high)), ((11, low)), ((11, low)), 
              ((11, low)), ((11, low)),((11, low)),((11, low)), 
              ((11, low)), ((11, low)), ((116, low)), ((116, low)), 
              ((116, low)), ((116, low)),((116, low)),((116, low)),
              ((116, low)), ((116, low)), ((0, low)), ((0, low)), 
              ((0, low)), ((0, low)),((0, low))]
-}