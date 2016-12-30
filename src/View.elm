module View exposing (view)

import Html exposing (Html, div, text, input, button)
import Html
import Html.Attributes exposing (class, type_, placeholder, value)
import Html.Events exposing (onInput, onClick)

import Messages exposing (Msg(..))
import Models exposing (Model)

import Reddit.Main as Reddit

import Navigation.Main as Nav


view : Model -> Html Msg
view model =
  div [class "cf"] 
    [ addRedditView model.newReddit
    , Nav.view model.selected model.redditList
    , Html.map RedditMsg (Reddit.view model.reddit)
    ] 



addRedditView : String -> Html Msg
addRedditView newReddit =
    div [] 
        [ input 
            [ type_ "text"
            , class "input-subreddit"
            , placeholder "Reddit name"
            , value newReddit
            , onInput InputRedditName
            ] []
        , button 
            [ class "btn"
            , onClick AddNewReddit
            ]
            [ text "add"]
        ]