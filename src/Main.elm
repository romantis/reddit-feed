module Main exposing (main)

import Html
import Messages exposing (Msg(..))
import Models exposing (Model, initModel)
import View exposing (view)
import Update exposing (update)

import Reddit.Main exposing (fetch)


init : ( Model, Cmd Msg )
init  =
    ( initModel "elm" ["reactjs", "angular", "elm"]
    , Cmd.map RedditMsg (fetch "elm")
    ) 


subscriptions : Model -> Sub Msg 
subscriptions _ =
    Sub.none 
        

main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }