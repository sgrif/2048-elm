import Rendering (..)
import GameModel (..)

main = renderGrid <| initialGrid

initialGrid = Grid
        [ [Nothing, Nothing, Nothing, Nothing]
        , [Nothing, Just 2, Just 2, Nothing]
        , [Nothing, Nothing, Nothing, Nothing]
        , [Nothing, Nothing, Nothing, Nothing]
        ]
