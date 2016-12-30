module Models exposing (..)

import Reddit.Main as Reddit



type alias Reddit = String

type alias Model =
    { selected : Reddit
    , redditList : List Reddit
    , reddit : Reddit.Model
    , newReddit: Reddit
    }



initModel : Reddit -> List Reddit -> Model
initModel selected myReddits  =
    { selected = selected
    , redditList = myReddits
    , reddit = Reddit.init selected
    , newReddit = ""
    }
