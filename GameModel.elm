module GameModel where

type Direction = Up | Left | Right | Down
type Grid = Grid (List (List (Maybe Int)))
