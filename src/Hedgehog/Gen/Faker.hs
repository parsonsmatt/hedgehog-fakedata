-- | A compatibility module to use "Faker" data in your "Hedgehog" tests.
module Hedgehog.Gen.Faker where

import           System.IO.Unsafe (unsafePerformIO)
import qualified Faker
import Faker (Fake)
import System.Random (mkStdGen)

import Hedgehog (Gen)
import qualified Hedgehog.Gen as Gen
import qualified Hedgehog.Range as Range
import qualified Hedgehog.Internal.Gen  as InternalGen
import qualified Hedgehog.Internal.Seed as InternalSeed

-- | Select a value 'Fake' program in 'Gen'.
--
-- @since 0.0.1.0
fake :: Fake a -> Gen a
fake f = do
    randomGen <- mkStdGen <$> Gen.integral_ Range.linearBounded
    pure $!
        unsafePerformIO $
        -- (parsonsmatt): OK so `unsafePerformIO` is bad, unless you know exactly
        -- what you're doing, so do I know exactly what I am doing? Perhaps I can
        -- convince you.
        --
        -- The Faker library doesn't keep the data as Haskell values, but stores it
        -- in `data-files`. The code that generates this fake data loads the values
        -- from the `data-files` for the library. That's what happens in IO. It is
        -- possible that the data-file is missing, and an exception will be thrown.
        -- However, no mutating actions are performed. I believe this is a safe use
        -- of 'unsafePerformIO'.
        --
        -- The alternative would be to lift it into `GenT IO a`, which is
        -- undesirable, as it would harm composition with basically any other
        -- generator.
        Faker.generateWithSettings
            (Faker.setRandomGen
              randomGen
              Faker.defaultFakerSettings
            )
            f
