module Navigation.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href, class, placeholder, type_, value)
import Html.Events exposing (onInput, onClick)
import Shared.Helpers exposing (hrefClick)
import Models exposing (Reddit, Model, Menu(..))
import Messages exposing (Msg(..))


(=>) : a -> b -> ( a, b )
(=>) = (,)


view : Model -> Html Msg
view model =
    nav [ class "navigation"] <| List.concat
        [ [iconMenuView model.iconMenu]
        , if model.iconMenu == Add then [addRedditView model.newReddit] else []
        , List.map (navItem model.selected (model.iconMenu == Edit)) model.redditList
        ]


navItem : Reddit -> Bool -> Reddit -> Html Msg
navItem selected isEdit reddit  =
    div [ class "cf navigation-item"]
        [ a
            [ class ""
            , classList ["active" => (reddit == selected) ]
            , hrefClick Select reddit
            , href <|  "/" ++ reddit
            ] 
            [ text reddit ]
        , if isEdit then
            i 
                [ class "fa fa-trash-o "
                , onClick <| RemoveReddit reddit
                ] []
         else text ""
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
            ] []
        , button 
            [ class "add-btn"
            , onClick AddNewReddit
            ]
            [ text "add"]
        ]

