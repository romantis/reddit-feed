module View exposing (view)

import Html exposing (Html, div)
import Html

import Messages exposing (Msg(..))
import Models exposing (Model)

import Reddit.Main as Reddit

import Shared.Header as Header


view : Model -> Html Msg
view {header, reddit} =
  div [] 
    [ Html.map HeaderMsg ( Header.view header)
    , Html.map RedditMsg (Reddit.view reddit)
    ] 

