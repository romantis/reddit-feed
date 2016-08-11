module Models exposing (..)

import Reddit.Main as Reddit

import Shared.Header as Header



type alias Model =
    { selected : String
    , header : Header.Model
    , reddit : Reddit.Model
    }


topics = 
    ["reactjs", "angular", "elm"]


initModel : String -> Model
initModel topic  =
    { selected = topic
    , header = Header.init topics topic
    , reddit = Reddit.init topic
    }
