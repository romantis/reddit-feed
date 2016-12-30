module Navigation.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href, class)
-- import Html.Events exposing (onClick)
import Shared.Helpers exposing (hrefClick)
import Models exposing (Reddit)
import Messages exposing (Msg(..))


(=>) : a -> b -> ( a, b )
(=>) = (,)



view : Reddit -> List Reddit -> Html Msg
view selected redditList  =
    nav [ class "navigation"]
        (List.map (navItem selected) redditList)


navItem : Reddit -> Reddit -> Html Msg
navItem selected reddit  =
    a 
        [ class "navigation-item"
        , classList ["active" => (reddit == selected) ]
        , hrefClick Select reddit
        , href <|  "/" ++ reddit
        ] 
        [ text reddit ]
