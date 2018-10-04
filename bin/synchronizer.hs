module Synchronizer where
import Clash.Explicit.Prelude

type Domain_user = Dom "user" 10000
type Domain_sensor = Dom "sensor" 9000

clkUser :: Clock Domain_user Source
clkUser = clockGen

clkSensor :: Clock Domain_sensor Source
clkSensor = clockGen

dualFlipFlop clkA clkB = delay clkB . delay clkB . unsafeSynchronizer clkA clkB