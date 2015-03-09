module Test.Utils.List where

import Random
import Debug (log)

import ElmTest.Test (..)
import ElmTest.Assertion (..)

import Utils.List (..)

tests = suite "Utils.List" [padTest, sampleTest, getTest]

padTest = suite "pad"
        [ test "appends default to end of list"
                (assertEqual [1, 2, 3, 0] (pad 4 0 [1, 2, 3]))
        , test "appends as many elements as necessary"
                (assertEqual ["a", "b", "c", "c", "c"] (pad 5 "c" ["a", "b"]))
        , test "when list is target length"
                (assertEqual [1, 2, 3] (pad 3 0 [1, 2, 3]))
        , test "when list is longer than target"
                (assertEqual [1, 2, 3, 4] (pad 3 0 [1, 2, 3, 4]))
        ]

sampleTest = suite "sample"
        [ test "selects a random element from the list"
                (assertEqual (Just 3) <| fst <| sample (Random.initialSeed 5) [1, 2, 3])
        , test "can select any element from the list"
                (assertEqual (Just 2) <| fst <| sample (Random.initialSeed 1425914048741) [1, 2, 3])
        , test "varies selection based on list size"
                (assertEqual (Just 4) <| fst <| sample (Random.initialSeed 384623423) [1, 2, 3, 4])
        ]

getTest = suite "get"
        [ test "gets the element at an index"
                (assertEqual (Just 1) (get 0 [1, 2, 3]))
        , test "gets any element in the list"
                (assertEqual (Just "b") (get 1 ["a", "b", "c"]))
        ]
