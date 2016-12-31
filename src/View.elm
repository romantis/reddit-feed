module View exposing (view)

import Html exposing (Html, div, text, input, button)
import Html
import Html.Attributes exposing (class)


import Messages exposing (Msg(..))
import Models exposing (Model)

import Reddit.Main as Reddit

import Navigation.Main as Nav


view : Model -> Html Msg
view model =
  div [class "cf"] 
    [ Nav.view model
    , Html.map RedditMsg (Reddit.view model.reddit)
    ]