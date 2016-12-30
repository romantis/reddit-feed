module Messages exposing (..)

import Navigation.Main as Nav
import Reddit.Main as Reddit
import Models

type Msg
  = NavigationMsg Nav.Msg
  | RedditMsg Reddit.Msg
  | InputRedditName Models.Reddit
  | AddNewReddit
  
