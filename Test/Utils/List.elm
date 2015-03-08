module Test.Utils.List where

import ElmTest.Test (..)
import ElmTest.Assertion (..)

import Utils.List (..)

tests = suite "Utils.List" [ padTest ]

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
