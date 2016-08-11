module View exposing (view)

import Html exposing (Html, div, text, h1)
-- import Html.Attributes exposing (class)
import Html.App as App

import Messages exposing (Msg(..))
import Models exposing (Model)

import Reddit.Main as Reddit
-- import NotFound.Main as NotFound

import Shared.Header as Header


view : Model -> Html Msg
view {header, reddit} =
  div [] 
    [ App.map HeaderMsg ( Header.view header)
    , App.map RedditMsg (Reddit.view reddit)
    ] 

