module SyncSafeMult where
import Clash.Explicit.Prelude
import Connectors_Sync

sync_safe_mult :: (KnownNat a, KnownNat b, c ~ (Unsigned b, BitVector a, Bit, BitVector a, Bit, Bit)) => Unsigned b -> c -> ((DataSync a), Busy) -> (c, ((DataSync a), Busy))
sync_safe_mult factor state input = (state', output)
  where
    (sideIn, sideOut) = input
    dataIn = data# sideIn
    sync = sync# sideIn
    busy = busy# sideOut
    (counter, buffer, isData, dataOut, syncOut, busyOut) = state
    
    (buffer', newData) = case sync==high of
      True -> (dataIn, high)
      False -> (buffer, isData)
    
    busy' = busy .|. isData
    
    counter' = case counter == (factor - 1) of
      True -> 0
      False -> counter + 1

    (dataOut', syncOut', isData') = case counter' == 0 of
      True -> case isData == high of
        True -> (buffer, high, low)
        False -> (dataOut, low, newData)
      False -> (dataOut, low, newData)
 
    state' = (counter', buffer', isData', dataOut', syncOut', busy')
    output = (DataSync dataOut syncOut, Busy busyOut)

syncSafeMult :: (KnownNat a, KnownNat b) => Clock domainA Source -> Reset domainA Asynchronous -> Clock domainB Source -> Reset domainB Asynchronous -> Unsigned a -> (Signal domainA (DataSync b), Signal domainB Busy) -> (Signal domainB (DataSync b), Signal domainA Busy)
syncSafeMult clkA rstA clkB rstB factor (dataIn, busyIn) = output'
  where
    input' = bundle (dataIn, unsafeSynchronizer clkB clkA busyIn)
    output = mealy clkA rstA (sync_safe_mult factor) (0, 0, low, 0, low, low) input'
    (sideOut', sideIn') = unbundle (output)
    output' = (unsafeSynchronizer clkA clkB sideOut', sideIn')


type DomainSensor = Dom "slow" 9000
type DomainUser = Dom "fast" 2250

testobject :: Signal DomainUser (BitVector 8, Bit, Bit) -> Signal DomainUser (BitVector 8)
testobject input = message
  where
    clkA = clockGen :: Clock DomainUser Source
    rstA = asyncResetGen :: Reset DomainUser Asynchronous
    clkB = clockGen :: Clock DomainSensor Source
    rstB = asyncResetGen :: Reset DomainSensor Asynchronous
    (inputData, inputSync, inputBusy) = unbundle (input)
    input' = ((DataSync<$>inputData<*>inputSync), unsafeSynchronizer clkA clkB (Busy<$>inputBusy)) 
    (dataOut, busy) = (syncSafeMult clkA rstA clkB rstB (4::(Unsigned 3)) input')
    message = unsafeSynchronizer clkB clkA (data#<$>dataOut)

testInputs = [(5, high, low), (4, low, low), (5, low, low), (5, low, low), (5, low, low), (11, low, low), (5, low, low), (5, low, low),
              (12, high, low), (4, low, low), (5, low, low), (5, low, low), (5, low, low), (5, low, low), (5, low, low), (5, low, low)]
