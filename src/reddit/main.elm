module Reddit.Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href)
import Http 
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
-- import Json.Encode as Encode
import List
import Dict exposing (Dict)






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
    = Select String
    | FetchReddit (Result Http.Error Reddit)





update : Msg -> Model -> (Model, Cmd Msg)
update msg ({reddits, selected} as model) = 
    case msg of 
        FetchReddit (Err err) ->
            let 
                _ = Debug.log "FetchReddit error" err
            in
                model ! []
        
        FetchReddit (Ok reddit) ->
            { model 
                | reddits = 
                    Dict.insert selected reddit reddits} ! []
            
        Select s -> 
            { model | selected = s} ! []






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


{-------- Commends and Decoders ---------------------------------------------------------- -}


fetch : String -> Cmd Msg
fetch route =
    Http.get (redditUrl route) decoder
        |> Http.send FetchReddit


fetchIfNeeded : String -> Model -> Cmd Msg 
fetchIfNeeded nextTopic model =
    let 
        isThere =
            Dict.member nextTopic model.reddits
    in
        if isThere then 
            Cmd.none 
        else 
            fetch nextTopic


redditUrl : String -> String
redditUrl route = 
    "https://www.reddit.com/r/" ++ route ++".json"


decoder : Decoder (List RedditItem)
decoder =
    JD.at 
        ["data", "children"] 
        (JD.list decodeReddit)


decodeReddit : Decoder RedditItem
decodeReddit =
    JD.field "data"
        ( decode RedditItem
            |> required "title" JD.string
            |> required "url" JD.string
        )
