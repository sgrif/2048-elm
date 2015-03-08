module Utils.List where

import List (..)

pad : Int -> a -> List a -> List a
pad targetLength default list =
  let missingLength = targetLength - (length list)
  in append list <| repeat missingLength default

transpose : List (List a) -> List (List a)
transpose ll = case ll of
    ((x::xs)::xss) -> (x :: (map head xss)) :: transpose (xs :: (map tail xss))
    otherwise -> []
