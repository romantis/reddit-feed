module Messages exposing (..)

import Navigation.Main as Nav
import Reddit.Main as Reddit

type Msg
  = NavigationMsg Nav.Msg
  | RedditMsg Reddit.Msg
  
