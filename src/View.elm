module View exposing (view)

import Html exposing (Html, div)
import Html
import Html.Attributes exposing (class)

import Messages exposing (Msg(..))
import Models exposing (Model)

import Reddit.Main as Reddit

import Navigation.Main as Nav


view : Model -> Html Msg
view {navigation, reddit} =
  div [class "cf"] 
    [ Html.map NavigationMsg ( Nav.view navigation)
    , Html.map RedditMsg (Reddit.view reddit)
    ] 

