import ElmTest.Test (..)
import ElmTest.Runner.Element (..)

import Test.Utils.List
import Test.GameLogic.Row
import Test.GameLogic.Grid
import Test.GameState

tests = suite "Main"
        [ Test.Utils.List.tests
        , Test.GameLogic.Row.tests
        , Test.GameLogic.Grid.tests
        , Test.GameState.tests
        ]

main = runDisplay tests
