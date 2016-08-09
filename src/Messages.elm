module Messages exposing (..)

import Shared.Header as Header
import Reddit.Main as Reddit

type Msg
  = HeaderMsg Header.Msg
  | RedditMsg Reddit.Msg
  
