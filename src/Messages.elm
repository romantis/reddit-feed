module Messages exposing (..)

import Reddit.Main as Reddit
import Models

type Msg
  = Select Models.Reddit
  | RedditMsg Reddit.Msg
  | InputRedditName Models.Reddit
  | AddNewReddit
  
