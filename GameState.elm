module GameState ( GameState
                 , GameStatus (..)
                 , stepGameState
                 , initialState
                 ) where

import Maybe (Maybe (..), withDefault, andThen)
import Maybe
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

stepGame dir originalState =
  assertPlaying originalState
    `andThen` moveGrid dir
    |> Maybe.map placeRandomTile
    |> Maybe.map checkIfLost
    |> withDefault originalState

assertPlaying state = case state.status of
  Playing -> Just state
  Lost -> Nothing

moveGrid dir state =
  let state' = { state | grid <- move dir state.grid }
  in if state == state' then Nothing else Just state'

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
