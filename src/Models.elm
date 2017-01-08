module Models exposing (..)

import Dict exposing (Dict)



type alias SubReddit = 
    { title : String
    , displayName : String
    }

type alias RedditArticle =
    { title: String 
    , url: String
    }

type alias Articles =
    Dict String (List RedditArticle)

type Menu
    = Edit
    | Add
    | Default

type alias Model =
    { selected : String
    , subRedditList : List SubReddit
    , articles : Articles
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
        , articles = Dict.empty
        , newReddit = ""
        , iconMenu = Default
        }
