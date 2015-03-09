module GameState ( GameState
                 , GameStatus (..)
                 , stepGameState
                 , initialState
                 ) where

import Maybe (Maybe (..), withDefault)
import Random

import GameLogic.Grid (..)
import GameModel (..)
import Input (..)
import Utils.List (sample)

type GameStatus = Playing | Lost
type alias GameState =
  { grid: Grid
  , seed: Random.Seed
  , status: GameStatus
  }

stepGameState : Input -> GameState -> GameState
stepGameState {direction} = case direction of
  Just dir -> stepGame dir
  Nothing -> identity

initialState : Input -> GameState
initialState {time} =
  let seed = Random.initialSeed <| round time
      emptyState = GameState emptyGrid seed Playing
  in placeRandomTile <| placeRandomTile emptyState

stepGame dir state =
  let step = moveGrid dir
               >> placeRandomTile
               >> checkIfLost
  in case state.status of
    Playing -> step state
    Lost -> state

moveGrid dir state = { state | grid <- move dir state.grid }

placeRandomTile state =
  let (randomTile, seed') = generateRandomTile state.seed
      (maybeCoords, seed'') = sample seed' <| emptyTiles state.grid
      coords = withDefault (0, 0) maybeCoords
      grid' = setTile randomTile coords state.grid
  in { state | grid <- grid', seed <- seed'' }

checkIfLost state = if hasPossibleMoves state.grid
                       then state
                       else { state | status <- Lost }

generateRandomTile seed =
  let (flt, seed') = Random.generate (Random.float 0 1) seed
      tile = if flt > 0.9 then Just 4 else Just 2
  in (tile, seed')
