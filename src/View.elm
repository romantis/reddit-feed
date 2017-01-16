module View exposing (view)

import Html exposing (Html, div, text, input, button)
import Html
import Html.Attributes exposing (class)


import Messages exposing (Msg(..))
import Models exposing (Model)

import Reddit.Articles as Articles

import Navigation.Main as Nav


view : Model -> Html Msg
view model =
  div [class "main cf"] 
    [ Nav.view model
    , Articles.view model.articles model.selected
    ]