module Messages exposing (..)

import Reddit.Articles as Articles
import Models exposing (Menu, SubReddit)

type Msg
  = Select String
  | ArticlesMsg Articles.Msg
  | InputRedditName String
  | AddNewReddit
  | SelectMenu Menu
  | RemoveReddit String