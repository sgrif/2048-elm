import Signal (..)

import GameModel (..)
import GameState (..)
import Input (..)
import Rendering (..)

main = renderGrid <~ grid

grid = .grid <~ foldp stepGameState initialState input
