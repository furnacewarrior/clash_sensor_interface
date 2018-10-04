module LightSensorTest where
import Clash.Explicit.Prelude
import LightSensor_Ctrl
import SPI_Ctrl

type DomainSensor = Dom "sensor" 9000

topEntity :: Clock DomainSensor Source -> Reset DomainSensor Asynchronous -> Signal DomainSensor Bit -> (Signal DomainSensor (BitVector 8), Signal DomainSensor Bit, Signal DomainSensor Bit, Signal DomainSensor Bit)
topEntity clkA rstA miso = (dataOut, mosi, cs, clkOut) 
  where
    ctrlOut = lightSensor_Ctrl clkA rstA ctrlIn
    spiOut = spi_Ctrl clkA rstA spiIn

    (clkOut, cs, mosi, spiDataOut, spiNextByte, spinextOutput) = unbundle spiOut
    spiIn = bundle (pure 0, ctrlFinished, miso, pure low)
    ctrlIn = bundle (spiNextByte, spinextOutput, spiDataOut)
    (dataOut, _, ctrlFinished) = unbundle ctrlOut

testobject :: Signal DomainSensor Bit -> Signal DomainSensor (BitVector 8, Bit)
testobject input = bundle (message, cs)
  where
    clkA = clockGen :: Clock DomainSensor Source
    rstA = asyncResetGen :: Reset DomainSensor Asynchronous
    (message, _, cs, _) = topEntity clkA rstA input

testInputs = [low,  high,high,high,high,low,low,low,low, low,low,low,low,low,low,low,low,  low,low,low,  high,low,low,low,high,low,low,low, high,high,high,high,low,low,low,low,  high,low,high,  low,high, low,high,low,high,low,high,low,high, low, high,low,high,low,high]