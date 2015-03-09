import Signal (..)
import Signal.Extra (foldp')

import GameModel (..)
import GameState (..)
import Input (..)
import Rendering (..)

main = renderGrid <~ foldp' stepGameState initialState input
