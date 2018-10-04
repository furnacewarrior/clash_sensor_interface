module Modules.Interfaces.SPI.CtrlSim where
import Clash.Explicit.Prelude
import qualified Modules.Interfaces.SPI.Ctrl as SPI
import ConnectorsStd

type DomainUser = Dom "user" 9000

{-# ANN topEntity
   (Synthesize
      { t_name   = "topEntity"
      , t_inputs = [ PortName "clk", 
                     PortName "rst",
                     PortProduct "spiIn" [ PortName "driverOut", PortName "sensorOut" ] ]
      , t_output = PortProduct "res" [PortName "sensorIn", PortName "driverIn", PortName "clkOut"] }) #-}
topEntity
  :: Clock DomainUser Source 
  -> Reset DomainUser Asynchronous 
  -> Signal DomainUser (ConnStd 15, Bit)
  -> (Signal DomainUser (Bit, Bit), Signal DomainUser (ConnStd 15), Clock DomainUser Gated)
topEntity clk rst input = SPI.main clk rst input (SPI.StreamR 15 0)


{-# ANN topEntity (TestBench 'testBench) #-}
testBench
  :: Signal DomainUser (BitVector 15, Bit, Bit)
testBench = bundle (data#<$>driver, newByte#<$>driver, busy#<$>driver)
  where
    testInput      = stimuliGenerator clk rst $(listToVecTH [(11, high,  low)::(BitVector 15, Bit, Bit), 
                                                             (11, low , high), 
                                                             (11, high,  low), 
                                                             (11, high, high), 
                                                             (11, high,  low), 
                                                             (11, high,  low), 
                                                             (11, high,  low), 
                                                             (11, low , high), 
                                                             (11, low , high), 
                                                             (11, low , high),  
                                                             (11, low ,  low), 
                                                             (11, low , high), 
                                                             (11, high, high), 
                                                             (11, high, high), 
                                                             (11, low , high), 
                                                             (11, low , high), 
                                                             (11, low , high),  
                                                             (11, low ,  low), 
                                                             (11, low , high), 
                                                             (11, high, high), 
                                                             (11, high, high)])
    (dataIn, finished, miso) = unbundle testInput
    input = bundle((ConnStd<$>dataIn<*>finished<*>(pure low)), miso)
    (sensor, driver, clkOut) = topEntity clk rst input
    (cs, mosi) = unbundle sensor
    done'        = pure True
    clk          = tbClockGen @DomainUser done'
    rst          = asyncResetGen @DomainUser 

--mainSim
--  :: Clock domain Source 
--  -> Reset domain Asynchronous 
--  -> Signal domain (ConnStd 15)
--  -> Signal domain (ConnStd 15)
--mainSim clk rst input = output
--  where
--    miso = lightSensorModel clkOut rst sensor
--    (sensor, driver, clkOut) = main clk rst (bundle (input, miso)) (14 :: (Unsigned 4)) StreamR
--    output = driver