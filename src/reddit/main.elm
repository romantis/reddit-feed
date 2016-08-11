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
init topic =
    Model Dict.empty topic




type Msg
    = FetchFail Http.Error 
    | FetchSuccess Reddit
    | Select String
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
        
        Select s -> 
            ( { model | selected = s}
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
                div [] 
                    [ h2 [] 
                        [ text "Reddit: " 
                        , b [] [text selected] 
                        ]
                    , ol [] (List.map redditItemView rx) 
                    ]
    


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

fetchIfNeeded : String -> Model -> Cmd Msg 
fetchIfNeeded nextTopic model =
    let 
        isThere =
            Dict.member nextTopic model.reddits
    in
        if isThere then 
            Cmd.none 
        else 
            fetchReddit nextTopic


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
