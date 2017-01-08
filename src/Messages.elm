module Messages exposing (..)

import Reddit.Articles as Articles
import Models exposing (Menu, Reddit)

type Msg
  = Select Reddit
  | ArticlesMsg Articles.Msg
  | InputRedditName String
  | AddNewReddit
  | SelectMenu Menu
  | RemoveReddit String