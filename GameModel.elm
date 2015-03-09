module GameModel ( Direction (..)
                 , Grid (..)
                 , Tile
                 , Coords
                 , tilesWithCoords
                 , emptyGrid
                 , emptyTiles
                 ) where

import List (..)

type Direction = Up | Left | Right | Down
type Grid = Grid (List (List (Maybe Int)))
type alias Tile = Maybe Int
type alias Coords = (Int, Int)

tilesWithCoords : Grid -> List ((Tile, Coords))
tilesWithCoords (Grid rows) =
  concat <| indexedMap rowWithCoords rows

rowWithCoords y row = indexedMap (tileWithCoords y) row

tileWithCoords y x tile = (tile, (x, y))

emptyGrid : Grid
emptyGrid = Grid <| repeat 4 <| repeat 4 Nothing

emptyTiles : Grid -> List Coords
emptyTiles =
  tilesWithCoords >> filter (fst >> isEmptyTile) >> map snd

isEmptyTile t = case t of
  Just _ -> False
  Nothing -> True
