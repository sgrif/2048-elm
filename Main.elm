import GameLogic.Grid (..)
import GameModel (..)
import Input (..)
import Rendering (..)
import Signal (..)

main = renderGrid <~ gameState

gameState = foldp stepGame initialGrid input

stepGame : Input -> Grid -> Grid
stepGame {direction} = case direction of
  Just d -> move d >> placeNewTile
  Nothing -> identity

initialGrid = Grid
        [ [Just 2, Nothing, Nothing, Nothing]
        , [Just 2, Nothing, Nothing, Just 2]
        , [Just 4, Nothing, Nothing, Nothing]
        , [Just 4, Nothing, Nothing, Nothing]
        ]
