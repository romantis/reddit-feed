module Models exposing (..)

import Reddit.Articles as Articles



type alias Reddit 
    = String

type Menu
    = Edit
    | Add
    | Default

type alias Model =
    { selected : Reddit
    , redditList : List Reddit
    , articles : Articles.Model
    , newReddit: Reddit
    , iconMenu : Menu
    }



initModel : List Reddit -> Model
initModel reddits=
    let 
        selected = 
            Maybe.withDefault "" <| List.head reddits
    
    in
        { selected = selected
        , redditList = reddits
        , articles = Articles.init selected
        , newReddit = ""
        , iconMenu = Default
        }
