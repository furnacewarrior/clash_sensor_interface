module SyncSafeMult where
import Clash.Explicit.Prelude
import ConnectorsStd

sync_safe_mult :: (KnownNat a, KnownNat b, c ~ (Unsigned b, BitVector a, Bit, BitVector a, Bit, Bit)) => Unsigned b -> c -> ((ConnStd a),(ConnStd a)) -> (c, ((ConnStd a),(ConnStd a)))
sync_safe_mult factor state input = (state', output)
  where
    (domAIn, domBIn) = input

    (inputFast, inputSlow) = case factor > 1 of
      True -> (domAIn, domBIn)
      False -> (domBIn, domAIn)
  
  
    dataInA = data# inputFast
    syncA = newByte# inputFast
    busyA = busy# inputFast

    dataInB = data# inputSlow
    syncB = newByte# inputSlow
    busyB = busy# inputSlow

    (counter, buffer, isData, dataOut, syncOut, busyOut) = state
    
    (buffer', newData) = case syncA==high of
      True -> (dataInA, high)
      False -> (buffer, isData)
    
    busy' = busyB .|. isData
    
    counter' = case counter == (factor - 1) of
      True -> 0
      False -> counter + 1

    (dataOut', syncOut', isData') = case counter' == 0 of
      True -> case isData == high of
        True -> (buffer, high, low)
        False -> (dataOut, low, newData)
      False -> (dataOut, low, newData)
 
    state' = (counter', buffer', isData', dataOut', syncOut', busy')
    output = ((ConnStd dataInB syncB busyOut), (ConnStd dataOut syncOut busyA))

syncSafeMult :: (KnownNat a, KnownNat b) => Clock domainA Source -> Reset domainA Asynchronous -> Clock domainB Source -> Reset domainB Asynchronous -> Unsigned a -> (Signal domainA (ConnStd b), Signal domainB (ConnStd b)) -> (Signal domainA (ConnStd b), Signal domainB (ConnStd b))
syncSafeMult clkA rstA clkB rstB factor (domAIn, domBIn) = (domAOut, domBOut)
  where
    input' = bundle (domAIn, unsafeSynchronizer clkB clkA domBIn)
    output = mealy clkA rstA (sync_safe_mult factor) (0, 0, low, 0, low, low) input'
    (domAOut, domBOut') = unbundle (output)
    domBOut = (unsafeSynchronizer clkA clkB domBOut')

{-
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
-}