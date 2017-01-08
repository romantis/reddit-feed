module Reddit.Articles exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class)
import Http 
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
-- import Json.Encode as Encode
import List
import Dict exposing (Dict)






type alias RedditArticle =
    { title: String 
    , url: String
    }

    

type alias Model =
    { articles: Dict String (List RedditArticle)
    , selected : String
    }





init : String -> Model
init subRedditName =
    Model Dict.empty subRedditName





type Msg
    = Select String
    | FetchReddit (Result Http.Error (List RedditArticle))





update : Msg -> Model -> (Model, Cmd Msg)
update msg ({articles, selected} as model) = 
    case msg of 
        FetchReddit (Err err) ->
            let 
                _ = Debug.log "FetchReddit error" err
            in
                model ! []
        
        FetchReddit (Ok reddit) ->
            { model 
                | articles = 
                    Dict.insert selected reddit articles} ! []
            
        Select s -> 
            { model | selected = s} ! []






view : Model -> Html Msg
view {articles, selected} =
    if selected == "" then 
        text "No reddits selected"

    else 
        case Dict.get selected articles of
            Nothing ->
                div [] [text ("Loading " ++ selected ++ " reddit...")]
            Just rx ->
                div [ class "content" ] 
                    [ h2 [] 
                        [ text "Reddit: " 
                        , span [ class "reddit-selected"] [ text selected ] 
                        ]
                    , ol [] (List.map redditArticleView rx) 
                    ]
    


redditArticleView : RedditArticle -> Html Msg
redditArticleView r =
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
fetchIfNeeded subRedditName model =
    let 
        isThere =
            Dict.member subRedditName model.articles
    in
        if isThere then 
            Cmd.none 
        else 
            fetch subRedditName


redditUrl : String -> String
redditUrl route = 
    "https://www.reddit.com/r/" ++ route ++".json"


decoder : Decoder (List RedditArticle)
decoder =
    JD.at 
        ["data", "children"] 
        (JD.list decodeReddit)


decodeReddit : Decoder RedditArticle
decodeReddit =
    JD.field "data"
        ( decode RedditArticle
            |> required "title" JD.string
            |> required "url" JD.string
        )
