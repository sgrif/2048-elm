import ElmTest.Test (..)
import ElmTest.Runner.Element (..)

import Test.Utils.List
import Test.GameLogic.Row
import Test.GameLogic.Grid

tests = suite "Main"
        [ Test.Utils.List.tests
        , Test.GameLogic.Row.tests
        , Test.GameLogic.Grid.tests
        ]

main = runDisplay tests
