module Navigation.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href, class, placeholder, type_, value, tabindex, autofocus)
import Html.Events exposing (onInput, onClick)
import Shared.Helpers exposing (hrefClick, onEnter, (=>)) 
import Models exposing (SubReddit, Model)
import Messages exposing (Msg(..))



view : Model -> Html Msg
view model =
    nav [ class "navigation" ]
        [ div [ class "navbar fx alco-center"]
            [ button 
                [ class "btn-nav btn-bars fa fa-bars"
                , classList ["active" => model.menuToggle]
                , onClick ToggleMenu
                ] []
            , addRedditView model.newReddit
            ]
        , div 
            [ class "menu-list"
            , classList [ "active" => model.menuToggle ]
            ] <| 
            List.map (navItem model.selected) model.subRedditList
        ]


navItem : String -> SubReddit -> Html Msg
navItem selected subReddit  =
    div [ class "cf navigation-item"]
        [ a
            [ classList ["active" => (subReddit.displayName == selected) ]
            , hrefClick Select subReddit.displayName
            , href <|  "/" ++ subReddit.displayName
            ] 
            [ text subReddit.title ]
        , button 
            [ class "btn-nav btn-delete fa fa-trash-o"
            , onClick <| RemoveReddit subReddit.displayName
            ] [] 
        ]



addRedditView : String -> Html Msg
addRedditView newReddit =
    div [ class "add-panel ml-auto" ] 
        [ input 
            [ type_ "text"
            , tabindex 0
            , autofocus True
            , class "input-reddit"
            , placeholder "Subreddit"
            , value newReddit
            , onInput InputRedditName
            , onEnter AddNewReddit
            ] []
        , button 
            [ class "add-btn"
            , onClick AddNewReddit
            ]
            [ text "add"]
        ]

