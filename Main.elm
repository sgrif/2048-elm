import GameLogic.Grid (..)
import GameModel (..)
import Input (..)
import Rendering (..)
import Signal (..)

main = renderGrid <~ gameState

gameState = foldp stepGame initialGrid input

stepGame : Input -> Grid -> Grid
stepGame {direction} = case direction of
  Just d -> move d
  Nothing -> identity

initialGrid = Grid
        [ [Nothing, Nothing, Nothing, Nothing]
        , [Nothing, Just 2, Just 2, Nothing]
        , [Nothing, Nothing, Nothing, Nothing]
        , [Nothing, Nothing, Nothing, Nothing]
        ]
