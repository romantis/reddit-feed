module Models exposing (..)

import Dict exposing (Dict)
import Time exposing (Time)



type alias SubReddit = 
    { title : String
    , displayName : String
    }

type alias Post =
    { title : String 
    , url : String
    , author : String
    , score : Int
    , created : Time
    , numComments : Int
    , thumbnail : String
    }

type alias Posts =
    Dict String (List Post)

type Menu
    = Edit
    | Add
    | Default

type alias Model =
    { selected : String
    , subRedditList : List SubReddit
    , posts : Posts
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
            
        iconMenu =
            if List.isEmpty subReddits then
                Add
            else 
                Default
        
    in
        { selected = selected
        , subRedditList = subReddits
        , posts = Dict.empty
        , newReddit = ""
        , iconMenu = iconMenu
        }
