module Models exposing (..)

import Routing exposing (routeString)
import Reddit.Main as Reddit

import Shared.Header as Header



type alias Model =
    { route : Routing.Route
    , header : Header.Model
    , reddit : Reddit.Model
    }


topics = 
    ["reactjs", "angular", "elm"]

initModel : Routing.Route -> Model
initModel route =
    let 
        rs = 
            routeString route
    in
        { route = route
        , header = Header.init topics rs
        , reddit = Reddit.init rs
        }
