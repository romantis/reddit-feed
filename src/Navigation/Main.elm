module Navigation.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href, class, placeholder, type_, value)
import Html.Events exposing (onInput, onClick)
import Shared.Helpers exposing (hrefClick)
import Models exposing (Reddit)
import Messages exposing (Msg(..))


(=>) : a -> b -> ( a, b )
(=>) = (,)



view : Reddit -> Reddit -> List Reddit -> Html Msg
view selected newReddit redditList =
    nav [ class "navigation"]
        ([ addRedditView newReddit
        ] ++ (List.map (navItem selected) redditList))


navItem : Reddit -> Reddit -> Html Msg
navItem selected reddit  =
    a 
        [ class "navigation-item"
        , classList ["active" => (reddit == selected) ]
        , hrefClick Select reddit
        , href <|  "/" ++ reddit
        ] 
        [ text reddit ]

addRedditView : String -> Html Msg
addRedditView newReddit =
    div [ class "add-panel" ] 
        [ input 
            [ type_ "text"
            , class "input-reddit"
            , placeholder "Reddit name"
            , value newReddit
            , onInput InputRedditName
            ] []
        , button 
            [ class "add-btn"
            , onClick AddNewReddit
            ]
            [ text "add"]
        ]