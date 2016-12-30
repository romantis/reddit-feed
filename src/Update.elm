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
            let 
                redditCmd = 
                    if selected == model.selected then 
                        Cmd.none 
                    else 
                        Cmd.map RedditMsg 
                            (Reddit.fetchIfNeeded selected model.reddit)
                reddit =
                    model.reddit
            in
                { model 
                    | selected = selected
                    , reddit = {reddit | selected = selected}  
                 } !
                    [ redditCmd
                    , modifyUrl ("#" ++ selected)
                    ]

        
        InputRedditName newReddit ->
            {model | newReddit = newReddit} ! []
        
        
        AddNewReddit ->
            let 
                reddit =
                    model.newReddit
                        |> String.trim
                        |> String.toLower
                        
                isValid =
                    not <| String.isEmpty reddit
                        
                
                updModel =
                    if isValid then
                        {model 
                            | redditList = model.redditList ++ [reddit]
                            , newReddit = "" }
                    else
                        model
            in
                updModel ! []


            
