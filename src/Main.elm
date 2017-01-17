module Main exposing (main)

import Html

import Messages exposing (Msg(..))
import Models exposing (Model, SubReddit, initModel)
import View exposing (view)
import Update exposing (update)

import Reddit.Posts exposing (fetch)


init : Maybe (List SubReddit) -> ( Model, Cmd Msg )
init mreddits  =
    let 
        subReddits =
            Maybe.withDefault [] mreddits
        
        initSubReddit =
            List.head subReddits
                |> Maybe.map .displayName
                |> Maybe.withDefault ""
        
        initCmd =
            if initSubReddit /= "" then
                fetch initSubReddit
            else 
                Cmd.none

    in
        ( initModel subReddits
        , initCmd
        ) 


subscriptions : Model -> Sub Msg 
subscriptions _ =
    Sub.none 
        

main : Program (Maybe (List SubReddit)) Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }