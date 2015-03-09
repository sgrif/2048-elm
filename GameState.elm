module GameState where

import Maybe (Maybe (..), withDefault)
import Random
import Debug

import GameLogic.Grid (..)
import GameModel (..)
import Input (..)
import Utils.List (sample)

type alias GameState = {
  grid: Grid,
  seed: Maybe Random.Seed
}

stepGameState : Input -> GameState -> GameState
stepGameState {direction, time} = case direction of
  Just dir -> stepGame dir time
  Nothing -> identity

initialState = GameState initialGrid Nothing

initialGrid = Grid
        [ [Just 2, Nothing, Nothing, Nothing]
        , [Just 2, Nothing, Nothing, Just 2]
        , [Just 4, Nothing, Nothing, Nothing]
        , [Just 4, Nothing, Nothing, Nothing]
        ]

stepGame : Direction -> Float -> GameState -> GameState
stepGame dir time {grid, seed} =
  let seed' = withDefault (seedFromTime time) seed
      grid' = move dir grid
      (grid'', seed'') = placeRandomTile grid' seed'
  in GameState grid'' <| Just seed''

seedFromTime = round >> Random.initialSeed

placeRandomTile grid seed =
  let (randomTile, seed') = Debug.log "random" (generateRandomTile seed)
      (maybeCoords, seed'') = sample seed' <| emptyTiles grid
      coords = withDefault (0, 0) maybeCoords
  in (setTile randomTile coords grid, seed'')

generateRandomTile seed =
  let (flt, seed') = Random.generate (Random.float 0 1) seed
      tile = if flt > 0.9 then Just 4 else Just 2
  in (tile, seed')
