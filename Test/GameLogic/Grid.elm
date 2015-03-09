module Test.GameLogic.Grid (tests) where

import ElmTest.Test (..)
import ElmTest.Assertion (..)

import GameLogic.Grid (..)
import GameModel (..)

tests = suite "GameLogic.Grid"
        [ moveTest
        , setTest
        ]

moveTest = suite "move"
        [ moveUp
        , moveRight
        , moveDown
        , moveLeft
        , movingMultiple
        ]

moveUp = test "moving up"
        (assertEqual
        (Grid [ [Just 4, Just 2, Just 4, Just 2]
              , [Just 2, Just 4, Nothing, Nothing]
              , [Nothing, Just 2, Nothing, Nothing]
              , [Nothing, Nothing, Nothing, Nothing]
              ])
         (move Up <| Grid [ [Just 2, Just 2, Nothing, Nothing]
                          , [Nothing, Just 4, Just 2, Nothing]
                          , [Just 2, Nothing, Just 2, Just 2]
                          , [Just 2, Just 2, Nothing, Nothing]
                          ]))

moveRight = test "moving right"
        (assertEqual
        (Grid [ [Nothing, Nothing, Just 2, Just 4]
              , [Nothing, Nothing, Just 8, Just 4]
              , [Nothing, Just 4, Just 2, Just 8]
              , [Just 2, Just 8, Just 4, Just 2]
              ])
        (move Right <| Grid [ [Just 2, Nothing, Just 2, Just 2]
                            , [Nothing, Nothing, Just 8, Just 4]
                            , [Just 4, Nothing, Just 2, Just 8]
                            , [Just 2, Just 8, Just 4, Just 2]
                            ]))

moveDown = test "moving down"
        (assertEqual
        (Grid [ [Nothing, Nothing, Nothing, Nothing]
              , [Just 8, Just 4, Nothing, Nothing]
              , [Just 2, Just 8, Nothing, Nothing]
              , [Just 8, Just 4, Just 2, Nothing]
              ])
        (move Down <| Grid [ [Just 4, Just 4, Just 2, Nothing]
                           , [Just 4, Just 8, Nothing, Nothing]
                           , [Just 2, Just 4, Nothing, Nothing]
                           , [Just 8, Nothing, Nothing, Nothing]
                           ]))

moveLeft = test "moving left"
        (assertEqual
        (Grid [ [Just 8, Just 2, Nothing, Nothing]
              , [Just 4, Just 8, Nothing, Nothing]
              , [Just 2, Just 4, Nothing, Nothing]
              , [Just 8, Nothing, Nothing, Nothing]
              ])
        (move Left <| Grid [ [Just 4, Just 4, Just 2, Nothing]
                           , [Just 4, Just 8, Nothing, Nothing]
                           , [Just 2, Just 4, Nothing, Nothing]
                           , [Just 8, Nothing, Nothing, Nothing]
                           ]))

movingMultiple = test "moving multiple"
        (assertEqual
        (Grid [ [Nothing, Nothing, Nothing, Nothing]
              , [Nothing, Nothing, Nothing, Nothing]
              , [Just 4, Just 4, Nothing, Nothing]
              , [Just 8, Just 4, Nothing, Just 2]
              ])
        (move Down <| Grid [ [Just 2, Just 2, Nothing, Nothing]
                           , [Just 2, Just 2, Nothing, Just 2]
                           , [Just 4, Just 2, Nothing, Nothing]
                           , [Just 4, Just 2, Nothing, Nothing]
                           ]))

setTest = test "setTile"
        (assertEqual
        (Grid [ [Just 2, Nothing, Nothing, Nothing]
              , [Nothing, Nothing, Nothing, Nothing]
              , [Just 4, Nothing, Nothing, Nothing]
              , [Just 8, Nothing, Nothing, Just 2]
              ])
        (setTile (Just 2) (0, 0)
                (Grid [ [Nothing, Nothing, Nothing, Nothing]
                      , [Nothing, Nothing, Nothing, Nothing]
                      , [Just 4, Nothing, Nothing, Nothing]
                      , [Just 8, Nothing, Nothing, Just 2]
                      ])))
