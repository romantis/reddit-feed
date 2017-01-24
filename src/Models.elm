module Models exposing (..)

import Dict exposing (Dict)
import Date exposing (Date)



type alias SubReddit = 
    { title : String
    , displayName : String
    }

type alias Post =
    { title : String 
    , url : String
    , author : String
    , score : Int
    , created : Date
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
    , now : Date
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
        , now = Date.fromTime (toFloat 0)
        }
