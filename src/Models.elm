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


type alias Model =
    { selected : String
    , subRedditList : List SubReddit
    , posts : Posts
    , newReddit: String
    , menuToggle : Bool
    , now : Date
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
        , posts = Dict.empty
        , newReddit = ""
        , menuToggle = False
        , now = Date.fromTime (toFloat 0)
        }
