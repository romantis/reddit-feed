module Main exposing (main)

import Html.App as App
import Messages exposing (Msg(..))
import Models exposing (Model, initModel)
import View exposing (view)
import Update exposing (update)

import Reddit.Main exposing (fetchReddit)


init : ( Model, Cmd Msg )
init  =
    ( initModel "nodejs"
    , Cmd.map RedditMsg (fetchReddit "nodejs")
    ) 


subscriptions : Model -> Sub Msg 
subscriptions model =
    Sub.none 
        


main : Program Never
main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }