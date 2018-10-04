module Modules.Drivers.LightSensor.CtrlSim where
import Clash.Explicit.Prelude
import qualified Modules.Drivers.LightSensor.Ctrl as LS
import ConnectorsStd

type DomainUser = Dom "user" 9000

{-# ANN topEntity
   (Synthesize
      { t_name   = "driverLS"
      , t_inputs = [ PortName "clk", 
                     PortName "rst",
                     PortProduct "driverLSIn" [ PortName "syncOut", PortName "spiOut" ] ]
      , t_output = PortProduct "driverLSOut" [PortName "syncIn", PortName "spiIn"] }) #-}
topEntity
  :: Clock DomainUser Source 
  -> Reset DomainUser Asynchronous 
  -> Signal DomainUser (ConnStd 8, ConnStd 15)
  -> Signal DomainUser (ConnStd 8, ConnStd 15)
topEntity clk rst input = LS.main clk rst input
{-# NOINLINE topEntity #-}

{-# ANN topEntity (TestBench 'testBench) #-}
testBench
  :: Signal DomainUser (BitVector 8)
testBench = bundle (data#<$>sync)
  where
    testInput      = stimuliGenerator clk rst $(listToVecTH [(0b000011011101000, high)::(BitVector 15, Bit), (0b000011011101000, high), (0b000011011101000, high)])
    (dataIn, newByte) = unbundle testInput
    input = bundle(ConnStd<$>(pure 0)<*>(pure low)<*>(pure low) ,ConnStd<$>dataIn<*>newByte<*>(pure low))
    (sync, spiCtrl) = unbundle(topEntity clk rst input)
    done'        = pure False
    clk          = tbClockGen @DomainUser done'
    rst          = asyncResetGen @DomainUser 

{-
driverLightSensorSim = output
  where
    clk = clockGen :: Clock DomainUser Source
    rst = asyncResetGen :: Reset DomainUser Asynchronous
    sensorOut = spiSim clk rst (ConnStd<$>(pure 0)<*>(newByte#<$>sensor)<*>(pure low))
    syncOut = ConnStd<$>(pure 0)<*>(pure low)<*>(pure low)
    (sync, sensor) = unbundle (driverLightSensor clk rst (bundle(syncOut,sensorOut)))
    output = bundle ((data#<$>sync), (newByte#<$>sync))
-}