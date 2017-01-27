module Shared.Spinner exposing(..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)


fadingCircleView : Html msg
fadingCircleView =
    div [ class "sk-fading-circle" ]
    [ div [ class "sk-circle1 sk-circle" ] []
    , div [ class "sk-circle2 sk-circle" ] []
    , div [ class "sk-circle3 sk-circle" ] []
    , div [ class "sk-circle4 sk-circle" ] []
    , div [ class "sk-circle5 sk-circle" ] []
    , div [ class "sk-circle6 sk-circle" ] []
    , div [ class "sk-circle7 sk-circle" ] []
    , div [ class "sk-circle8 sk-circle" ] []
    , div [ class "sk-circle9 sk-circle" ] []
    , div [ class "sk-circle10 sk-circle" ] []
    , div [ class "sk-circle11 sk-circle" ] []
    , div [ class "sk-circle12 sk-circle" ] []
    ]