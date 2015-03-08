module Input (Input, input) where

import Keyboard
import Maybe (..)
import Random
import Signal (..)

import GameModel (..)

type alias Input = {
    direction: Maybe Direction
}

input : Signal Input
input = Input <~ playerDirection

playerDirection : Signal (Maybe Direction)
playerDirection = toDirection <~ Keyboard.arrows

toDirection dir =
  if | dir == { x = 0,  y = 1  } -> Just Up
     | dir == { x = 0,  y = -1 } -> Just Down
     | dir == { x = 1,  y = 0 }  -> Just Right
     | dir == { x = -1, y = 0 }  -> Just Left
     | otherwise                 -> Nothing
