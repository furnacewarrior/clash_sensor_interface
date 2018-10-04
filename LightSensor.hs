module LightSensor where
import Clash.Explicit.Prelude
import Synchronizer
import qualified Modules.Drivers.LightSensor.Ctrl as LS
import qualified Modules.Interfaces.SPI.Ctrl as SPI
import LightSensor_I
import LightSensorModel
import ConnectorsStd

type DomainSensor = Dom "sensor" 50 -- 9000
type DomainUser = Dom "user" 50 --9000

topEntity :: Clock DomainUser Source -> 
             Reset DomainUser Asynchronous -> 
             Clock DomainSensor Source -> 
             Reset DomainSensor Asynchronous -> 
             Signal DomainSensor Bit -> 
             (Signal DomainUser (BitVector 8), Signal DomainSensor Bit, Signal DomainSensor Bit, Clock DomainSensor Gated)
topEntity clkA rstA clkB rstB miso = (dataOut', mosi, cs, clkOut) 
  where
    (spiToSensor, spiToDriver, clkOut) = SPI.main clkB rstB spiIn (SPI.StreamR 15 0)
    (driverToSync, driverToSpi) = unbundle (LS.main clkB rstB (bundle (syncToDriver, spiToDriver)))
    spiIn = bundle (driverToSpi, miso)
    (syncToInt, syncToDriver) = synchronizer clkA rstA clkB rstB (7000, 4000) (intToSync, driverToSync)
    (dataOut', intToSync) = unbundle(lightSensor_I clkA rstA syncToInt)
    (cs, mosi) = unbundle (spiToSensor)
 
testBench
  :: Signal DomainUser (BitVector 8)
testBench = dataOut
  where
    testInput      = stimuliGenerator clkB2 rstB2 $(listToVecTH [low::Bit, low, high, high, low, low, high, high, low, low, high, low, high, low, low, high, high, low, low, high, low, high, low, low, high, high, low, low, high, low])
    (dataOut, mosi, cs, clkOut) = topEntity clkA1 rstA1 clkB2 rstB2 testInput
    done'          = pure False
    clkA1          = tbClockGen @DomainUser done'
    clkB2          = tbClockGen @DomainSensor done'
    rstA1          = asyncResetGen @DomainUser
    rstB2          = asyncResetGen @DomainSensor 

{-
testObject :: Signal DomainUser (BitVector 8)
testObject = message
  where
    clkA = clockGen :: Clock DomainUser Source
    rstA = asyncResetGen :: Reset DomainUser Asynchronous
    clkB = clockGen :: Clock DomainSensor Source
    rstB = asyncResetGen :: Reset DomainSensor Asynchronous
    (dataOut, mosi, cs, clkOut) = topEntity clkA rstA clkB rstB miso
    miso = lightSensorModel clkOut rstB (bundle (cs, mosi))
    message = dataOut
-}