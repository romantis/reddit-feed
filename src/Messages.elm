module Messages exposing (..)

import Http 
import Time exposing (Time)
import Models exposing (SubReddit, Post)

type Msg
  = Select String
  | InputRedditName String
  | AddNewReddit
  | RemoveReddit String
  | FetchReddit (Result Http.Error (List Post))
  | NewTime Time
  | ToggleMenu