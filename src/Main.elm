module Main exposing (main)

import Html
import Time exposing (minute)
import Task

import Messages exposing (Msg(..))
import Models exposing (Model, SubReddit, initModel)
import View exposing (view)
import Update exposing (update)

import Reddit.Posts exposing (fetch)


defaultSubreddits =
    [ SubReddit "Movies" "Movies"
    , SubReddit "Jokes" "Jokes"
    , SubReddit "Programming" "Programming"
    , SubReddit "Cats" "Cats"
    ]

init : Maybe (List SubReddit) -> ( Model, Cmd Msg )
init mreddits  =
    let 
        _ = Debug.log "Maybe Subreddits" mreddits
        subReddits =
            Maybe.withDefault defaultSubreddits mreddits
        
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
        (initModel subReddits) !  [initCmd, nowTime]



nowTime : Cmd Msg
nowTime =
    Task.perform NewTime Time.now

subscriptions : Model -> Sub Msg 
subscriptions _ =
    Time.every minute NewTime
    
        
        

main : Program (Maybe (List SubReddit)) Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }