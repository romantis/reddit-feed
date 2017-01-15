module Navigation.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href, class, placeholder, type_, value)
import Html.Events exposing (onInput, onClick)
import Shared.Helpers exposing (hrefClick, onEnter, (=>)) 
import Models exposing (SubReddit, Model, Menu(..))
import Messages exposing (Msg(..))



view : Model -> Html Msg
view model =
    nav [ class "navigation"
        , classList ["edit-mode" => (model.iconMenu == Edit) ]
        ] <| List.concat
        [ [iconMenuView model.iconMenu]
        , if model.iconMenu == Add then [addRedditView model.newReddit] else []
        , List.map (navItem model.selected (model.iconMenu == Edit)) model.subRedditList
        ]


navItem : String -> Bool -> SubReddit -> Html Msg
navItem selected editing subReddit  =
    let
        deleteBtn =
            i 
                [ class "fa fa-trash-o"
                , onClick <| RemoveReddit subReddit.displayName
                ] []
        
        attrs =
            [ classList ["active" => (subReddit.displayName == selected) ]
            , hrefClick Select subReddit.displayName
            , href <|  "/" ++ subReddit.displayName
            ] 
    in
        div [ class "cf navigation-item"]
            [ a
                (if not editing then attrs else [ href "#"])
                [ text subReddit.title ]
            , if editing then deleteBtn else text ""
            ]


iconMenuView : Menu -> Html Msg
iconMenuView menu =
    let 
        activeClass current =
            classList 
                ["active" => (menu == current) ]
    in 
        div [ class "icon-navigation"]
            [ i 
                [ class "fa fa-pencil-square-o fa-lg"
                , activeClass Edit
                , onClick <| SelectMenu Edit
                ] []
            , i 
                [ class "fa fa-plus fa-lg"
                , activeClass Add
                , onClick <| SelectMenu Add
                ] []
            ]


addRedditView : String -> Html Msg
addRedditView newReddit =
    div [ class "add-panel" ] 
        [ input 
            [ type_ "text"
            , class "input-reddit"
            , placeholder "Reddit name"
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

