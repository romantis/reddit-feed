module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)


import Messages exposing (Msg(..))
import Reddit.Main as Reddit
import Shared.Header as Header 



update : Msg -> Model -> (Model, Cmd Msg)
update msg ({header, reddit} as model) =
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
                
                nextTopic =
                    subModel.selected

                redditCmd = 
                    if model.header.selected == subModel.selected then 
                        Cmd.none 
                    else 
                        Cmd.map 
                            RedditMsg 
                            (Reddit.fetchIfNeeded nextTopic model.reddit)
                
            in
                ({ model 
                    | header = subModel
                    , reddit = {reddit |  selected = nextTopic}  
                 }
                , Cmd.batch 
                    [ Cmd.map HeaderMsg subCmd
                    , redditCmd
                    ]
                )


