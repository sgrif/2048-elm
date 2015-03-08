module GameLogic.Grid (Grid (..), move) where

import List (map, reverse)

import GameLogic (Direction (..))
import GameLogic.Row as Row
import Utils.List (transpose)

type Grid = Grid (List (List (Maybe Int)))

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

shift (Grid rows) = Grid <| map Row.slide rows
