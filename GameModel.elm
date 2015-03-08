module GameModel ( Direction (..)
                 , Grid (..)
                 , Tile
                 , Coords
                 , tilesWithCoords
                 ) where

import List (indexedMap, concat)

type Direction = Up | Left | Right | Down
type Grid = Grid (List (List (Maybe Int)))
type alias Tile = Maybe Int
type alias Coords = (Int, Int)

tilesWithCoords : Grid -> List ((Tile, Coords))
tilesWithCoords (Grid rows) =
  concat <| indexedMap rowWithCoords rows

rowWithCoords y row = indexedMap (tileWithCoords y) row

tileWithCoords y x tile = (tile, (x, y))
