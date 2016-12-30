module Models exposing (..)

import Reddit.Main as Reddit

import Navigation.Main as Nav



type alias Reddit = String

type alias Model =
    { selected : Reddit
    , navigation : Nav.Model
    , reddit : Reddit.Model
    , newReddit: Reddit
    }



initModel : Reddit -> List Reddit -> Model
initModel selected myReddits  =
    { selected = selected
    , navigation = Nav.init myReddits selected
    , reddit = Reddit.init selected
    , newReddit = ""
    }
