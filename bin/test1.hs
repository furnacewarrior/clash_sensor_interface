import Data.List
import System.IO
import System.Random

rollDice :: IO Int
rollDice = getStdRandom (randomR (1,6))
