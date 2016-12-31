module Messages exposing (..)

import Reddit.Main as Reddit
import Models exposing (Menu)

type Msg
  = Select Models.Reddit
  | RedditMsg Reddit.Msg
  | InputRedditName Models.Reddit
  | AddNewReddit
  | SelectMenu Menu
  | RemoveReddit Models.Reddit