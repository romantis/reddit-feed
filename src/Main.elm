module Main exposing (main)

import Navigation
import Dict
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Routing exposing (Route(..), routeString)

import Reddit.Main as Reddit




init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
        
        model =
            initialModel currentRoute
    in
        ( model
        , urlUpdCmd model 
        ) 




subscriptions : Model -> Sub Msg 
subscriptions model =
    Sub.none 
        



urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result ({route, header, reddit} as model) =
    let
        current =
            Routing.routeFromResult result
        rs =
            routeString current
        
        newModel =
            {model 
                | route = current
                , header = {header | selected = rs}
                , reddit = {reddit | selected = rs}}
    in
        ( newModel
        , urlUpdCmd newModel 
        )



urlUpdCmd : Model -> Cmd Msg
urlUpdCmd {route, reddit} =
    case route of 
        RedditRoute selected ->
            if Dict.member selected reddit.reddits then
                Cmd.none
            else 
                Cmd.map RedditMsg (Reddit.fetchReddit selected)
        _ ->
            Cmd.none 


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }