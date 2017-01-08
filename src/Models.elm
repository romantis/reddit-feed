module Models exposing (..)

import Reddit.Articles as Articles



type alias SubReddit = 
    { title : String
    , displayName : String
    }

type Menu
    = Edit
    | Add
    | Default

type alias Model =
    { selected : String
    , subRedditList : List SubReddit
    , articles : Articles.Model
    , newReddit: String
    , iconMenu : Menu
    }



initModel : List SubReddit -> Model
initModel subReddits=
    let 
        selected =
            List.head subReddits
                |> Maybe.map .displayName
                |> Maybe.withDefault ""
            
    
    in
        { selected = selected
        , subRedditList = subReddits
        , articles = Articles.init selected
        , newReddit = ""
        , iconMenu = Default
        }
