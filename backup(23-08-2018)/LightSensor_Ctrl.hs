--https://store.digilentinc.com/pmod-als-ambient-light-sensor/
module LightSensor_Ctrl where
import Clash.Explicit.Prelude
import SPI_Ctrl
import Connectors_SPI
import Connectors_Sync

--	Lightsensor controller, reads signal from spi controller, interped it and converts it to a suitable format format
--	for synchronization.
--	
--					+------------+
--	clk			-->	|			 | <--	dataIn
--	rst			-->	|Light Sensor| -->	finished
--	dataOut(8)	<--	| Controller | <--	nextOutput
--	sync		<--	|			 |
--					+------------+

spi_lightSensor# :: (BitVector 4, BitVector 2, BitVector 8, Bit, Bit) -> SPI_Ctrl_out 8 -> ((BitVector 4, BitVector 2, BitVector 8, Bit, Bit), (DataSync 8, SPI_Ctrl_in 8))
spi_lightSensor# state input = (state', output)
  where
    dataIn = dataOut# input
    nextOutput = newByte# input

    (buffer, stateL, dataOut, sync, finished) = state
    state' = case nextOutput == high of
      True -> case stateL of
                0 -> ((slice d4 d1 dataIn), 1, dataOut, low, low)
                1 -> (buffer, 2, buffer ++# (slice d7 d4 dataIn), high, high)
                2 -> (buffer, 0, dataOut, low, low)
      False -> (buffer, stateL, dataOut, low, low)
    output = ((DataSync dataOut sync), (SPI_Ctrl_in_noData_noBusy finished))
  
spi_lightSensor## clk rst = mealy clk rst spi_lightSensor# (0, 2, 0, low, low)

lightSensor_Ctrl :: Clock domain Source -> Reset domain Asynchronous -> Signal domain (SPI_Ctrl_out 8) -> Signal domain ((DataSync 8, SPI_Ctrl_in 8))
lightSensor_Ctrl clk rst = spi_lightSensor## clk rst

lightSensor_Ctrl_sim clk rst = output
  where
    driverIn = spi_Ctrl_sim clk rst (SPI_Ctrl_in_noData_noBusy<$>(finished#<$>finished)) ((7 :: Unsigned 3), True)
    (sync, finished) = unbundle (lightSensor_Ctrl clk rst driverIn)
    output = data#<$>sync


-- Test Code
type DomainIn = Dom "fast" 9000

clock:: Clock DomainIn Source
clock = clockGen

reset:: Reset DomainIn Asynchronous
reset = asyncResetGen

testObject = lightSensor_Ctrl_sim clock reset

testInputs = [(low, low, 208), (low, low, 208), (low, high, 48), (low, low, 48), (low, low, 48), (low, low, 48), (low, low, 48), (low, low, 48),
              (high, low, 48), (low, low, 48), (low, high, 144), (low, low, 144), (low, low, 144), (low, low, 144), (low, low, 144), (low, low, 144),
              (high, low, 144), (low, low, 144), (low, high, 6), (low, low, 6), (low, low, 6), (low, low, 6)]