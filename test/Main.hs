module Main where

import Hedgehog
import Faker
import Faker.Name
import Hedgehog.Gen.Faker
import qualified Hedgehog.Gen as Gen
import qualified Data.Set as Set
import Control.Monad

main :: IO ()
main = do
    let nameGen = 5
    xs <- Set.fromList <$> replicateM nameGen (Gen.sample (fake name))
    when (length xs /= nameGen) $
        fail "Should be 5"
