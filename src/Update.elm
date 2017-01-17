module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, SubReddit, Menu(..))
import Messages exposing (Msg(..))
import Ports exposing (setStorage)
import Reddit.Posts exposing (fetchIfNeeded)

import Navigation  exposing (modifyUrl)
import Dict

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Select selected ->
            let 
                redditCmd = 
                    if selected == model.selected then 
                        Cmd.none 
                    else 
                        fetchIfNeeded selected model.posts
                posts =
                    model.posts
            in
                { model 
                    | selected = selected } !
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
                            | subRedditList = model.subRedditList ++ [SubReddit reddit reddit]
                            , newReddit = "" }
                    else
                        model
            in
                updModel ! 
                    [setStorage updModel.subRedditList]
        

        SelectMenu menu ->
            if menu /= model.iconMenu then
                {model | iconMenu = menu} ! []
            else 
                {model | iconMenu = Default } ! []


            
        RemoveReddit reddit ->
            let 
                subRedditList = 
                    List.filter ((/=) reddit << .displayName) model.subRedditList
                updCmd =
                    if subRedditList /= model.subRedditList then
                        setStorage subRedditList
                    else 
                        Cmd.none
            in
                { model | subRedditList = subRedditList } ! [updCmd] 

        FetchReddit (Err err) ->
            let 
                _ = Debug.log "FetchReddit error" err
            in
                model ! []
        
        FetchReddit (Ok reddit) ->
            { model 
                | posts = 
                    Dict.insert model.selected reddit model.posts} ! []