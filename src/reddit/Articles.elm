module Reddit.Articles exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class)
import Http 
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import List
import Dict 

import Models exposing (RedditArticle, Articles)
import Messages exposing (Msg(..))







view : Articles -> String -> Html Msg
view articles selected =
    div [ class "content" ] <| 
    if selected == "" then 
        [ text "Add some subreddit" ]

    else 
        case Dict.get selected articles of
            Nothing ->
                [ i [class "fa fa-spinner fa-pulse fa-3x fa-fw"] []
                ]
            Just rx ->
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


fetchIfNeeded : String -> Articles -> Cmd Msg 
fetchIfNeeded subRedditName articles =
    let 
        isThere =
            Dict.member subRedditName articles
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
