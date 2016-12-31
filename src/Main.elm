module Main exposing (main)

import Html

import Messages exposing (Msg(..))
import Models exposing (Model, Reddit, initModel)
import View exposing (view)
import Update exposing (update)

import Reddit.Main exposing (fetch)


init : Maybe (List Reddit) -> ( Model, Cmd Msg )
init mreddits  =
    ( initModel <| Maybe.withDefault [] mreddits
    , Cmd.none
    ) 


subscriptions : Model -> Sub Msg 
subscriptions _ =
    Sub.none 
        

main : Program (Maybe (List Reddit)) Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }