module Shared.Header exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href)
-- import Html.Events exposing (onClick)
import Shared.Helpers exposing (hrefClick)

import Navigation

(=>) : a -> b -> ( a, b )
(=>) = (,)



type alias Model =
    { topics : List String
    , selected : String
    }


init : List String -> String -> Model
init topics selected = 
    Model
        topics 
        selected


type Msg 
    = Navigate String



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of

        Navigate url ->
            ( model
            , Navigation.newUrl url
            )


view : Model -> Html Msg
view {topics, selected} =
    header []
        [ nav []
            (List.map (navItem selected) topics)
        ]


navItem : String -> String -> Html Msg
navItem currentRoute route =
    let
        url = 
            "#" ++ route
    in
        a 
            [ classList ["active" => (currentRoute == route) ]
            , hrefClick Navigate url
            , href url 
            ]
            [ text route ]


