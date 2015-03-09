module Test.GameLogic.Row where

import Maybe (..)
import List (..)

import ElmTest.Test (..)
import ElmTest.Assertion (..)

import GameLogic.Row (..)

tests = suite "GameLogic.Row"
        [ slideTests
        ]

slideTests = suite "slide"
        [ test "moves elements to the left"
                (assertEqual
                [Just 2, Nothing, Nothing, Nothing]
                (slide [Nothing, Nothing, Nothing, Just 2]))
        , test "removes gaps"
                (assertEqual
                [Just 2, Just 4, Nothing, Nothing]
                (slide [Just 2, Nothing, Just 4, Nothing]))
        , test "combines like elements"
                (assertEqual
                [Just 4, Nothing, Nothing, Nothing]
                (slide [Just 2, Nothing, Just 2, Nothing]))
        , test "does complex combination"
                (assertEqual
                [Just 2, Just 8, Just 2, Nothing]
                (slide [Just 2, Just 4, Just 4, Just 2]))
        , test "combining multiple"
                (assertEqual
                [Just 8, Just 4, Nothing, Nothing]
                (slide [Just 4, Just 4, Just 2, Just 2]))
        , test "does not recurisively combine"
                (assertEqual
                [Just 4, Just 4, Nothing, Nothing]
                (slide <| repeat 4 <| Just 2))
        , test "never combines newly created tiles"
                (assertEqual
                [Just 4, Just 4, Nothing, Nothing]
                (slide [Just 2, Just 2, Just 4, Nothing]))
        ]
