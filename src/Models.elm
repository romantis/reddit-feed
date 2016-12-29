module Models exposing (..)

import Reddit.Main as Reddit

import Navigation.Main as Nav



type alias Model =
    { selected : String
    , navigation : Nav.Model
    , reddit : Reddit.Model
    }


topics = 
    ["reactjs", "angular", "elm"]


initModel : String -> Model
initModel topic  =
    { selected = topic
    , navigation = Nav.init topics topic
    , reddit = Reddit.init topic
    }
