module Reddit.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Http 
import Json.Decode as Decode exposing ((:=))
-- import Json.Encode as Encode
import Task
import List
import Dict exposing (Dict, insert)


type alias RedditItem =
    { title: String 
    , url: String
    }

type alias Reddit = 
    List RedditItem

type alias Model =
    { reddits: Dict String Reddit
    , selected : String
    }


init : String -> Model
init route =
    Model Dict.empty route




type Msg
    = FetchFail Http.Error 
    | FetchSuccess Reddit
    -- | FetchReddit String 


update : Msg -> Model -> (Model, Cmd Msg)
update msg ({reddits, selected} as model) = 
    case msg of 
        FetchFail _ ->
            ( model
            , Cmd.none
            )
        
        FetchSuccess reddit ->
            ({ model 
                | reddits = 
                    insert selected reddit reddits}
            , Cmd.none
            )

        -- FetchReddit topic ->
        --     ( model
        --     , fetchReddit topic
        --     )


view : Model -> Html Msg
view {reddits, selected} =
    if selected == "" then 
        text "No reddits selected"

    else 
        case Dict.get selected reddits of
            Nothing ->
                div [] [text ("Loading " ++ selected ++ " reddit...")]
            Just rx ->
                ol [] (List.map redditItemView rx) 
    


redditItemView : RedditItem -> Html Msg
redditItemView r =
    li [] 
        [ a 
            [ href r.url ]
            [ text r.title]
        ] 


{- #####################
         Commends
########################-}

fetchReddit : String -> Cmd Msg
fetchReddit route =
    Http.get decoder (redditUrl route)
        |> Task.perform FetchFail FetchSuccess 

redditUrl : String -> String
redditUrl route = 
    "https://www.reddit.com/r/" ++ route ++".json"


decoder : Decode.Decoder (List RedditItem)
decoder =
    Decode.at ["data", "children"] (Decode.list ("data":= redditDecoder))


redditDecoder : Decode.Decoder RedditItem
redditDecoder =
    Decode.object2 RedditItem
        ("title" := Decode.string)
        ("url" := Decode.string)
