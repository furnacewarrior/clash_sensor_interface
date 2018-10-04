module SPI where
import Clash.Explicit.Prelude

type DomainIn = Dom "fast" 9000

spi state (input, miso) = (state', output)
  where
    (inputBuffer#, outputBuffer#) = state
    ss = high
    outputBuffer = outputBuffer# <<+ input  -- To sensor
    inputBuffer = inputBuffer# <<+ miso  -- To user
    output = ((v2bv outputBuffer), (v2bv inputBuffer), ss)
    state' = (inputBuffer, outputBuffer)
  
spiController clk rst = mealy clk rst spi (bv2v 0, bv2v 0)  

topEntity :: Clock DomainIn Source -> Reset DomainIn Asynchronous -> Signal DomainIn (Bit, Bit) -> Signal DomainIn (BitVector 8, BitVector 8, Bit)
topEntity clk rst = spiController clk rst

testObject input = topEntity clockGen asyncResetGen input

testInputs = [(low,low),(low,high),(low,high),(high,low)]