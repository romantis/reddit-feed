module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Menu(..))

import Messages exposing (Msg(..))
import Reddit.Main as Reddit
import Ports exposing (setStorage)

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
                updModel ! 
                    [setStorage updModel.redditList]
        

        SelectMenu menu ->
            if menu /= model.iconMenu then
                {model | iconMenu = menu} ! []
            else 
                {model | iconMenu = Default } ! []


            
        RemoveReddit reddit ->
            let 
                redditList = 
                    List.filter ((/=) reddit) model.redditList
                updCmd =
                    if redditList /= model.redditList then
                        setStorage redditList
                    else 
                        Cmd.none
            in
                { model | redditList = redditList } ! [updCmd]