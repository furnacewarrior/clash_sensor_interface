module I2C_Ctrl where
import Clash.Explicit.Prelude

addrGen dataIn dataSize = 0b11110 ++# (slice d1 d0 dataIn) ++# boolToBit (dataSize == 0) ++# (slice d6 d0 dataIn) ++# boolToBit (dataSize == 0)

I2C_controller state input = (state', output)
  where
	(sdaIn, setAddr, setData, dataIn) = input
    (stateInt, counter, clkCounter, clkEnable, dataPtr, addrSize, addrMem, dataSize, dataMem, scl, sda, ready, dataOut, sync, error) = state
	
	-- Clock generator ---------------------------
    factor = 4
    halfClk = factor / 2
    (clkCounter', clkInternalEdge) = case clkEnable of
      True -> case clkCounter < factor of
        True -> (clkCounter + 1, False)
        False -> (0, True)
      False -> (0, False)
    clkInternal = case clkCounter < halfClk of
      True -> high
      False -> low
    ----------------------------------------------

    (stateInt', counter', dataPtr', clkEnable',  addrSize', dataSize', addrMem', dataMem', scl', sda', ready', dataOut', sync', error') = case stateInt of
      0 -> case setData == high of
        True -> case dataSize of         
          3 ->         (0, 0, 0, False, 0,            4, 0, dataMem <<+ dataIn, high, high, high, dataOut, low, low)
          4 ->         (0, 0, 0, False, 0,            4, 0,            dataMem, high, high, high, dataOut, low, low)
          otherwise -> (0, 0, 0, False, 0, dataSize + 1, 0, dataMem <<+ dataIn, high, high, high, dataOut, low, low)
        False -> case setAddr == high of  -- Load address and data
          True -> case addrSize of 
            0 ->         (0, 0, 0, False, addrSize + 1, dataSize,           addrGen dataIn dataSize, dataMem, high, high, high, dataOut, low, low)
            1 ->         (0, 0, 0, False,            2, dataSize, (slice d13 d7 addrMem) ++# dataIn, dataMem, high, high, high, dataOut, low, low)
            otherwise -> (0, 0, 0, False,            2, dataSize,                           addrMem, dataMem, high, high, high, dataOut, low, low)
          False -> (1, 0, 0, False, addrSize, dataSize, addrMem, dataMem, high, low, low, dataOut, low, low)
      1 -> (2, 0, 0, False, addrSize, dataSize, addrMem, dataMem, low, low, low, dataOut, low, low) -- Reset slaves
	  2 -> (3, 0, 0, False, addrSize, dataSize, addrMem, dataMem, low, (slice d13 d13 addrMem), low, dataOut, low, low) -- Make ready for adres sending 
      3 -> case clkInternalEdge of  -- Send address
        True -> case addrSize == dataPtr of			
          False -> case counter of
            7 -> (3, 0, dataPtr + 1, addrSize, dataSize, shiftL addrMem, dataMem, clkInternal, low, low, dataOut, low, low)	  		
            otherwise -> (2, counter + 1, dataPtr, addrSize, dataSize, shiftL addrMem, dataMem, clkInternal, (slice d13 d13 addrMem), low, dataOut, low, low)
          True -> (4, 0, dataPtr + 1, addrSize, dataSize, shiftL addrMem, dataMem, clkInternal, (slice d13 d13 addrMem), low, dataOut, low, low)	  		
        False -> (stateInt, counter, dataPtr,  addrSize, dataSize, addrMem, dataMem, scl, sda, ready, dataOut, sync, low)
      3 -> case clkInternalEdge of -- Wait for ack
	    True -> case sdaIn == high of
		  True -> (0, 0, 0, 0, 0, 0, 0, high, high, high, dataOut, low, high)	  		
		  False -> (2, counter, dataPtr, addrSize, dataSize, addrMem, dataMem, clkInternal, sda, ready, dataOut, sync, low )
	    True -> case dataSize == 0 of  
	    False -> (stateInt, counter, dataPtr,  addrSize, dataSize, addrMem, dataMem, scl, sda, ready, dataOut, sync)
    state' = (stateInt', counter', clkCounter', clkEnable', dataPtr', addrSize', addrMem', dataSize', dataMem', scl', sda', ready', dataOut', sync', error') 
    output = (scl, sda, ready, dataOut, sync, error)