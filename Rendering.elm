module Rendering (renderGrid) where

import Color (rgb)
import Graphics.Collage (..)
import Graphics.Element (..)
import List (..)
import Text (plainText)

import GameModel (..)

renderGrid : Grid -> Element
renderGrid grid =
  let tiles = tilesWithCoords grid |> map renderTileAtCoords
  in
     collage (round gridWidth) (round gridWidth) ([gridBox] ++ tiles)

gridBox = filled gridBackground <| square gridWidth

gridBackground = rgb 187 173 160

gridWidth = 4.0 * tileSize + 5.0 * tileMargin

tileSize = 106.25

tileMargin = 15

renderTileAtCoords : (Tile, Coords) -> Form
renderTileAtCoords (tile, coords) =
  move (tilePosition coords) <| toForm <| renderTile tile

renderTile = plainText << toString

tilePosition (x, y) =
  (
    (tileSize + tileMargin) * (toFloat x - 1.5)
  , (-1) * (tileSize + tileMargin) * (toFloat y - 1.5)
  )
