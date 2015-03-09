module GameLogic.Row (slide, setTile) where

import Array
import List (..)

import GameModel (..)
import Utils.List (pad)

slide : List Tile -> List Tile
slide = filter nonEmpty >> combineMatching >> pad 4 Nothing

setTile : Tile -> Int -> List Tile -> List Tile
setTile tile i row =
  let row' = Array.fromList row
      newRow = Array.set i tile row'
  in Array.toList newRow

nonEmpty a = case a of
  Just _ -> True
  _ -> False

combineMatching xs = case xs of
  Just a :: Just b :: ys ->
    if a == b
      then Just (a + b) :: combineMatching ys
      else Just a :: (combineMatching <| Just b :: ys)
  _ -> xs
