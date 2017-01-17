module Messages exposing (..)

import Http 
import Models exposing (Menu, SubReddit, Post)

type Msg
  = Select String
  | InputRedditName String
  | AddNewReddit
  | SelectMenu Menu
  | RemoveReddit String
  | FetchReddit (Result Http.Error (List Post))