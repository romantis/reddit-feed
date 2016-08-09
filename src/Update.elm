module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)


import Messages exposing (Msg(..))
import Reddit.Main as Reddit
import Shared.Header as Header 



update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        RedditMsg subMsg ->
            let 
                (subModel, subCmd) =
                    Reddit.update subMsg model.reddit
            in
                ( { model | reddit = subModel }
                , Cmd.map RedditMsg subCmd
                )
        
        
        HeaderMsg subMsg ->
            let 
                (subModel, subCmd) =
                    Header.update subMsg model.header
            in
                ( { model | header = subModel }
                , Cmd.map HeaderMsg subCmd
                )


