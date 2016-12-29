module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)


import Messages exposing (Msg(..))
import Reddit.Main as Reddit
import Navigation.Main as Nav



update : Msg -> Model -> (Model, Cmd Msg)
update msg ({navigation, reddit} as model) =
    case msg of
        RedditMsg subMsg ->
            let 
                (subModel, subCmd) =
                    Reddit.update subMsg model.reddit
            in
                ( { model | reddit = subModel }
                , Cmd.map RedditMsg subCmd
                )
        
        
        NavigationMsg subMsg -> 
            let 
                (subModel, subCmd) =
                    Nav.update subMsg model.navigation
                
                nextTopic =
                    subModel.selected

                redditCmd = 
                    if model.navigation.selected == subModel.selected then 
                        Cmd.none 
                    else 
                        Cmd.map RedditMsg (Reddit.fetchIfNeeded nextTopic model.reddit)
                
            in
                ({ model 
                    | navigation = subModel
                    , reddit = {reddit |  selected = nextTopic}  
                 }
                , Cmd.batch 
                    [ Cmd.map NavigationMsg subCmd
                    , redditCmd
                    ]
                )


