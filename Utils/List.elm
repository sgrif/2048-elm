module Utils.List where

import Array
import List (..)
import Maybe (Maybe (..))
import Random
import Debug

get : Int -> List a -> Maybe a
get idx = Array.get idx << Array.fromList

pad : Int -> a -> List a -> List a
pad targetLength default list =
  let missingLength = targetLength - (length list)
  in append list <| repeat missingLength default

transpose : List (List a) -> List (List a)
transpose ll = case ll of
    ((x::xs)::xss) -> (x :: (map head xss)) :: transpose (xs :: (map tail xss))
    otherwise -> []

sample : Random.Seed -> List a -> (Maybe a, Random.Seed)
sample seed lst =
  let (idx, seed') = Random.generate (Random.int 0 (length lst - 1)) seed
  in (get idx lst, seed')
