module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)

import Messages exposing (Msg(..))
import Reddit.Main as Reddit

import Navigation  exposing (modifyUrl)

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
        
        Select selected ->
            ( {model | selected = selected}
            , modifyUrl ("#" ++ selected)
            )

        
        InputRedditName newReddit ->
            {model | newReddit = newReddit} ! []
        
        
        AddNewReddit ->
            model ! []
            -- let 
            --     reddit =
            --         newReddit
            --             |> String.trim
            --             |> String.toLower
                        
            --     isValid =
            --         String.isEmpty reddit
                
            --     updModel =
            --         if isValid then
            --             {model | }
            -- in
            --     updModel ! []