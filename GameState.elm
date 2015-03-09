module GameState ( GameState
                 , stepGameState
                 , initialState
                 ) where

import Maybe (Maybe (..), withDefault)
import Random

import GameLogic.Grid (..)
import GameModel (..)
import Input (..)
import Utils.List (sample)

type alias GameState = {
  grid: Grid,
  seed: Random.Seed
}

stepGameState : Input -> GameState -> GameState
stepGameState {direction} = case direction of
  Just dir -> stepGame dir
  Nothing -> identity

initialState : Input -> GameState
initialState {time} =
  let seed = Random.initialSeed <| round time
      emptyState = GameState emptyGrid seed
  in placeRandomTile <| placeRandomTile emptyState

stepGame dir state =
  placeRandomTile { state | grid <- move dir state.grid }

placeRandomTile {grid,seed} =
  let (randomTile, seed') = generateRandomTile seed
      (maybeCoords, seed'') = sample seed' <| emptyTiles grid
      coords = withDefault (0, 0) maybeCoords
      grid' = setTile randomTile coords grid
  in GameState grid' seed''

generateRandomTile seed =
  let (flt, seed') = Random.generate (Random.float 0 1) seed
      tile = if flt > 0.9 then Just 4 else Just 2
  in (tile, seed')
