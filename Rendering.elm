module Rendering (renderGrid) where

import Color (..)
import Graphics.Collage (..)
import Graphics.Element (..)
import List (..)
import Text (..)

import GameModel (..)
import GameState (GameState, GameStatus (..))

renderGrid : GameState -> Element
renderGrid {grid, status} =
  let tiles = tilesWithCoords grid |> map renderTileAtCoords
      gameOverOverlay = case status of
        Playing -> []
        Lost -> gameOver
  in
     collage (round gridWidth) (round gridWidth) ([gridBox] ++ tiles ++ gameOverOverlay)

gridBox = filled gridBackground <| square gridWidth

gridBackground = rgb 187 173 160

gameOver = [filled gameOverBackground <| square gridWidth, toForm <| plainText "Game Over"]

gameOverBackground = rgba 255 255 255 0.4

gridWidth = 4.0 * tileSize + 5.0 * tileMargin

tileSize = 106.25

tileMargin = 15

renderTileAtCoords : (Tile, Coords) -> Form
renderTileAtCoords (tile, coords) =
  move (tilePosition coords) <| toForm <| renderTile tile

renderTile tile =
  let
      tileBackground = filled (tileColor tile) <| square tileSize
      render = collage (round tileSize) (round tileSize)
  in case tile of
    Just n -> render
        [ tileBackground
        , toForm <| centered
                 <| style (tileTextStyle tile)
                 <| fromString
                 <| toString n
        ]
    Nothing -> render [tileBackground]

tilePosition (x, y) =
  (
    (tileSize + tileMargin) * (toFloat x - 1.5)
  , (-1) * (tileSize + tileMargin) * (toFloat y - 1.5)
  )

tileColor : Maybe Int -> Color
tileColor tile = case tile of
  Just 2 -> rgb 238 228 218
  Just 4 -> rgb 237 224 200
  Just 8 -> rgb 242 177 121
  Just 16 -> rgb 245 149 99
  Just 32 -> rgb 246 124 95
  Just 64 -> rgb 246 94 59
  Just 128 -> rgb 237 207 114
  Just 256 -> rgb 237 204 97
  Just 512 -> rgb 237 200 80
  Just 1024 -> rgb 237 197 63
  Just 2048 -> rgb 237 194 46
  otherwise -> rgba 238 228 218 0.35

tileTextColor : Maybe Int -> Color
tileTextColor tile = case tile of
  Just n -> if n >= 8
               then (rgb 249 246 242)
               else (rgb 119 110 101)
  otherwise -> black

tileTextSize : Maybe Int -> Float
tileTextSize tile = case tile of
  Just 128 -> 45
  Just 256 -> 45
  Just 512 -> 45
  Just 1024 -> 35
  Just 2048 -> 35
  otherwise -> 55

tileTextStyle : Maybe Int -> Style
tileTextStyle tile = {
  typeface = [ "Helvetica Neue", "Arial", "sans-serif" ]
             , height = Just <| tileTextSize tile
             , color = tileTextColor tile
             , bold = True
             , italic = False
             , line = Nothing
           }
