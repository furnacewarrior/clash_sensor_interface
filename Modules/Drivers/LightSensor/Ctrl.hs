--https://store.digilentinc.com/pmod-als-ambient-light-sensor/
module Modules.Drivers.LightSensor.Ctrl(main, version) where
import Clash.Explicit.Prelude
import ConnectorsStd

----------------------------------------------------------------------------------------------------------------
--	Lightsensor controller, reads signal from spi controller, interped it and converts it to a suitable format format
--	for synchronization.
--	
--					+------------+
--	clk			-->	|			 | 
--	rst			-->	|Light Sensor| <--	spiOut
--	syncIn		<--	| Controller | -->	spiIn
--	syncOut		-->	|			 |
--					+------------+
--
-- No busy detection included, better loosing data than providing old data
----------------------------------------------------------------------------------------------------------------

data CtrlState = WaitPulse | OutputData
type CtrlStateInternal = (CtrlState, BitVector 8, Bit, Bit) 

version = "1.0"

ctrl :: CtrlStateInternal -> (ConnStd 8, ConnStd 15) -> CtrlStateInternal
ctrl state input = state'
  where
    (inputSync, inputSensor) = input

    {-< Input from sensor >-}
    dataSensor = data# inputSensor
    newByteSensor = newByte# inputSensor
    busySensor = busy# inputSensor

    {-< Input from Synchroniser >-}
    dataSync = data# inputSync
    newByteSync = newByte# inputSync
    busySync = busy# inputSync

    {-< Load state >-}
    (stateL, dataOut, sync, finished) = state

    {-< Set new state >-}
    stateNext = case stateL of
      WaitPulse -> case newByteSensor == high of
        True -> OutputData
        False -> WaitPulse
      OutputData -> WaitPulse

    state' = case stateNext of
      WaitPulse  -> (stateNext,                   dataOut, low ,  low)
      OutputData -> (stateNext, (slice d10 d3 dataSensor), high,  low)

ctrlOut
  :: CtrlStateInternal -> (ConnStd 8, ConnStd 15)
ctrlOut state = output
  where
    (stateL, dataOut, sync, finished) = state
    output = ((ConnStd dataOut sync low), (ConnStd 0 finished low))

ctrlMoore clk rst = moore clk rst ctrl ctrlOut (WaitPulse, 0, low, low)

main :: Clock domain Source -> Reset domain Asynchronous -> Signal domain (ConnStd 8, ConnStd 15) -> Signal domain (ConnStd 8, ConnStd 15)
main clk rst input = bundle (outputSync, outputSensor)
  where
    (inputSync, inputSensor) = unbundle input  
    dataSensor = data#<$>inputSensor
    newByteSensor = newByte#<$>inputSensor

    dataOut = slice<$>(pure d10)<*>(pure d3)<*>dataSensor
    newByteOut = newByteSensor

    outputSync = ConnStd<$>dataOut<*>newByteOut<*>(pure low)
    outputSensor = ConnStd<$>(pure 0)<*>(pure low)<*>(pure low)