module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, SubReddit)
import Messages exposing (Msg(..))
import Ports exposing (setStorage)
import Reddit.Posts exposing (fetchIfNeeded)

import Navigation  exposing (modifyUrl)
import Dict
import Date

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
                    | selected = selected
                    , menuToggle = False } !
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
                    (not <| String.isEmpty reddit)
                    && (not <| List.member reddit (List.map .displayName model.subRedditList))
                        
                
                updModel =
                    if isValid then
                        {model 
                            | subRedditList = 
                                [SubReddit reddit reddit]
                                    |> List.append model.subRedditList
                                    |> List.sortBy .title
                            , newReddit = "" }
                    else
                        model
            in
                updModel ! 
                    [setStorage updModel.subRedditList]
        

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
        
        NewTime time ->
            {model | now = Date.fromTime time} ! []
        
        ToggleMenu ->
            {model | menuToggle = not model.menuToggle} ! []