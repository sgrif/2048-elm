module Input (Input, input) where

import Keyboard
import Maybe (..)
import Signal (..)
import Time

import GameModel (..)

type alias Input = {
  direction: Maybe Direction,
  time: Float
}

input : Signal Input
input = (uncurry <| flip Input) <~ Time.timestamp playerDirection

playerDirection = toDirection <~ Keyboard.arrows

toDirection dir =
  if | dir == { x = 0,  y = 1  } -> Just Up
     | dir == { x = 0,  y = -1 } -> Just Down
     | dir == { x = 1,  y = 0 }  -> Just Right
     | dir == { x = -1, y = 0 }  -> Just Left
     | otherwise                 -> Nothing
