module Main exposing (main)

import Html

import Messages exposing (Msg(..))
import Models exposing (Model, Reddit, initModel)
import View exposing (view)
import Update exposing (update)

import Reddit.Articles exposing (fetch)


init : Maybe (List Reddit) -> ( Model, Cmd Msg )
init mreddits  =
    let 
        subReddits =
            Maybe.withDefault [] mreddits
        
        initSubReddit =
            Maybe.withDefault "" <| List.head subReddits
        
        initCmd =
            if initSubReddit /= "" then
                Cmd.map ArticlesMsg <| fetch initSubReddit
            else 
                Cmd.none

    in
        ( initModel subReddits
        , initCmd
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