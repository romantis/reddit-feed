module View exposing (view)

import Html exposing (Html, div, text, h1)
-- import Html.Attributes exposing (class)
import Html.App as App

import Messages exposing (Msg(..))
import Models exposing (Model)
import Routing exposing (Route(..), routeString)

import Reddit.Main as Reddit
import NotFound.Main as NotFound

import Shared.Header as Header


view : Model -> Html Msg
view model =
  div [] 
    [ App.map HeaderMsg ( Header.view model.header)
    , page model
    ] 


page : Model -> Html Msg
page model = 
    case model.route of 
        RedditRoute _ ->
            App.map RedditMsg (Reddit.view model.reddit)  
        
        NotFoundRoute ->
            NotFound.view
