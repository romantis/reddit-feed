module Models exposing (..)

import Reddit.Main as Reddit



type alias Reddit = String

type Menu
    = Edit
    | Add
    | Default

type alias Model =
    { selected : Reddit
    , redditList : List Reddit
    , reddit : Reddit.Model
    , newReddit: Reddit
    , iconMenu : Menu
    }



initModel : List Reddit -> Model
initModel reddits=
    { selected = ""
    , redditList = reddits
    , reddit = Reddit.init ""
    , newReddit = ""
    , iconMenu = Default
    }
