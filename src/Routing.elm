module Routing exposing (..)

import String
import Navigation
import UrlParser exposing (..)

-- import Models exposing (topics)


type Route
    = NotFoundRoute
    | RedditRoute String


routeString : Route -> String
routeString route =
    case route of
        RedditRoute s -> s 
        _ -> ""
            
        
-- format RedditRoute (s "")
-- format RedditRoute (string)
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [format RedditRoute (string)
        ]
         


hashParser : Navigation.Location -> Result String Route
hashParser location =
    location.hash
        |> String.dropLeft 1
        |> parse identity matchers


parser : Navigation.Parser (Result String Route)
parser =
    Navigation.makeParser hashParser


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute 

