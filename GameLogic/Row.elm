module GameLogic.Row (slide) where

import List (..)

import Utils.List (pad)

slide : List (Maybe Int) -> List (Maybe Int)
slide = filter nonEmpty >> combineMatching >> pad 4 Nothing

nonEmpty a = case a of
  Just _ -> True
  _ -> False

combineMatching xs = case xs of
  Just a :: Just b :: ys ->
    if a == b
      then Just (a + b) :: ys
      else Just a :: (combineMatching <| Just b :: ys)
  _ -> xs
