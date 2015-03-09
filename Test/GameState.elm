module Test.GameState where

import Maybe (..)
import Random

import ElmTest.Test (..)
import ElmTest.Assertion (..)

import GameState (..)
import GameModel (..)
import Input (Input)

tests = suite "GameState" [stepGameStateTests]

stepGameStateTests = suite "stepGameState"
        [ test "does nothing when given no direction"
                (assertEqual identity <| stepGameState <| Input Nothing 0.0)
        , test "does nothing when game is lost"
                (assertEqual lostGameState <| stepGameState (Input (Just Down) 0.0) lostGameState)
        , test "game is lost when no possible moves"
                (assertEqual Lost <| .status <| stepGameState (Input (Just Down) 0.0) gameOneMoveFromLosing)
        , test "game is not lost when moves possible but board is full"
                (assertEqual Playing <| .status <| stepGameState (Input (Just Up) 0.0) gameOneMoveFromLosing)
        ]

gameOneMoveFromLosing =
  { seed = Random.initialSeed 0
  , status = Playing
  , grid = Grid [ [Just 2, Just 4, Just 8, Just 4]
                , [Just 4, Just 8, Just 16, Just 4]
                , [Just 8, Just 16, Just 32, Just 64]
                , [Just 16, Just 32, Just 64, Just 128]
                ]
  }

lostGameState =
  { seed = Random.initialSeed 0
  , status = Lost
  , grid = emptyGrid
  }
