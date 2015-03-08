module GameLogic.Grid (move) where

import List (map, reverse)

import GameModel (..)
import GameLogic.Row as Row
import Utils.List (transpose)

move : Direction -> Grid -> Grid
move dir = rotateFrom dir << shift << rotateTo dir

rotateTo : Direction -> Grid -> Grid
rotateTo dir = case dir of
  Up -> rotateClockwise
  Right -> rotateClockwise >> rotateClockwise
  Down -> rotateClockwise >> rotateClockwise >> rotateClockwise
  Left -> identity

rotateFrom : Direction -> Grid -> Grid
rotateFrom dir = case dir of
  Up -> rotateClockwise >> rotateClockwise >> rotateClockwise
  Right -> rotateClockwise >> rotateClockwise
  Down -> rotateClockwise
  Left -> identity

rotateClockwise : Grid -> Grid
rotateClockwise (Grid rows) = Grid <| transpose <| map reverse rows

shift (Grid rows) = Grid <| map shiftRow rows

shiftRow row =
  let shifted = Row.slide row
  in
     if shifted == row
        then row
        else shiftRow shifted
