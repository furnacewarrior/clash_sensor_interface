module LightSensor where
import Clash.Explicit.Prelude
import Synchronizer
import LightSensor_Ctrl
import SPI_Ctrl
import LightSensor_I
import LightSensorModel
import Connectors_Sync
import Connectors_SPI

type DomainSensor = Dom "sensor" 9000
type DomainUser = Dom "user" 9000


topEntity :: Clock DomainUser Source -> 
             Reset DomainUser Asynchronous -> 
             Clock DomainSensor Source -> 
             Reset DomainSensor Asynchronous -> 
             Signal DomainSensor Bit -> 
             (Signal DomainUser (BitVector 8), Signal DomainSensor Bit, Signal DomainSensor Bit, Clock DomainSensor Gated)
topEntity clkA rstA clkB rstB miso = (dataOut', mosi, cs, clkOut) 
  where
    spiIn = bundle (ctrlLsOut, miso)
    (spiSensor, spiData, clkOut) = spi_Ctrl clkB rstB spiIn (7 :: Unsigned 3, False)
    (ctrlLsDataOut, ctrlLsOut) = unbundle (lightSensor_Ctrl clkB rstB spiData)
    (dataOut, busyOut) = synchronizer clkB rstB clkA rstA (7000, 4000) (ctrlLsDataOut, Busy<$>(pure low))
    dataOut' = lightSensor_I clkA rstA dataOut
    (cs, mosi) = unbundle (spiSensor)
 
{-
testobject :: Signal DomainUser (BitVector 8)
testobject = message
  where
    clkA = clockGen :: Clock DomainUser Source
    rstA = asyncResetGen :: Reset DomainUser Asynchronous
    clkB = clockGen :: Clock DomainSensor Source
    rstB = asyncResetGen :: Reset DomainSensor Asynchronous
    (dataOut, mosi, cs, clkOut) = topEntity clkA rstA clkB rstB miso
    miso = lightSensorModel clkOut rstB (bundle (cs, mosi))
    message = dataOut
-}