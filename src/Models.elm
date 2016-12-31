module Models exposing (..)

import Reddit.Main as Reddit



type alias Reddit = String

type alias Model =
    { selected : Reddit
    , redditList : List Reddit
    , reddit : Reddit.Model
    , newReddit: Reddit
    }



initModel : List Reddit -> Model
initModel reddits=
    { selected = ""
    , redditList = reddits
    , reddit = Reddit.init ""
    , newReddit = ""
    }
