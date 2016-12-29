module Navigation.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (classList, href)
-- import Html.Events exposing (onClick)
import Shared.Helpers exposing (hrefClick)
import Navigation  exposing (modifyUrl)


(=>) : a -> b -> ( a, b )
(=>) = (,)



type alias Model =
    { topics : List String
    , selected : String
    }


init : List String -> String -> Model
init topics selected = 
    Model
        topics 
        selected


type Msg 
    = Select String



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of

        Select topic ->
            ( {model | selected = topic}
            , modifyUrl ("#" ++ topic)
            )


view : Model -> Html Msg
view {topics, selected} =
    header []
        [ nav []
            (List.map (navItem selected) topics)
        ]


navItem : String -> String -> Html Msg
navItem currentRoute topic =
    let
        url = 
            "/" ++ topic
    in
        a 
            [ classList ["active" => (currentRoute == topic) ]
            , hrefClick Select topic
            , href url 
            ]
            [ text topic ]


