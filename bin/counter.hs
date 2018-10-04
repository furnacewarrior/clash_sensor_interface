module Counter where
import CLaSH.Prelude

gate :: BitVector 16 -> BitVector 16 -> BitVector 16
gate val1 val2 = val1 `xor` val2
