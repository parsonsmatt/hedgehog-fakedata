# hedgehog-fakedata

[![Build Status](https://travis-ci.org/parsonsmatt/hedgehog-fakedata.svg?branch=master)](https://travis-ci.org/parsonsmatt/hedgehog-fakedata)
![Hackage-Deps](https://img.shields.io/hackage-deps/v/hedgehog-fakedata)

This library lets you re-use the [fakedata](https://hackage.haskell.org/package/fakedata) library to quickly and easily generate fake data for use in [`hedgehog`](https://hackage.haskell.org/package/hedgehog) generators.

```haskell
import qualified Hedgehog.Gen as Gen
import qualified Faker.Name as Faker
import           Hedgehog.Gen.Faker (fake)

main :: IO ()
main = do
    print =<< Gen.sample (fake Faker.name)
```
