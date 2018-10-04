module Test where
import Clash.Explicit.Prelude

type SizeOut = 5
type SizeIn a =

testfunc :: (KnownNat a, (b ~ SizeIn a)) => Unsigned a -> Unsigned b -> Unsigned 3
testfunc aa bb = 4