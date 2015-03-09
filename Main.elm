import Signal (..)
import Signal.Extra (foldp')

import GameModel (..)
import GameState (..)
import Input (..)
import Rendering (..)

main = renderGrid
        << .grid
        <~ foldp' stepGameState initialState input
