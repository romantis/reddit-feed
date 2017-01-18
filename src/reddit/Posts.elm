module Reddit.Posts exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, src)
import Http 
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import List
import Dict 
import Date
import Date.Format exposing (format)

import Models exposing (Post, Posts)
import Messages exposing (Msg(..))







view : Posts -> String -> Html Msg
view posts selected =
    div [ class "content" ] <| 
    if selected == "" then 
        [ text "Add subreddits" ]

    else 
        case Dict.get selected posts of
            Nothing ->
                [ i [ class "fa fa-spinner fa-pulse fa-3x fa-fw fixed-center"] []
                ]
            Just rx ->
                    [ h2 [] 
                        [ text "Subreddit: " 
                        , span [ class "reddit-selected"] [ text selected ] 
                        ]
                    , ol [] (List.map redditPostView rx) 
                    ]
        


redditPostView : Post -> Html Msg
redditPostView r =
    li [ class "post"] 
        [ span [] [ text <| toString r.score]
        , a 
            [ href r.url ]
            [ img [src r.thumbnail ] []
            , h3 [] [text r.title]
            ]
        , p []
            [ text "by "
            , a [ href <| "https://www.reddit.com/user/" ++ r.author] [text r.author]
            ]
        , p [] 
            [ text <| format "%B %d, %Y at %I:%M%P " (Date.fromTime r.created)
            ]
        , p []
            [ text "Comments: "
            , text <| toString r.numComments
            ]
        ]


{-------- Commends and Decoders ---------------------------------------------------------- -}


fetch : String -> Cmd Msg
fetch route =
    Http.get (redditUrl route) decoder
        |> Http.send FetchReddit


fetchIfNeeded : String -> Posts -> Cmd Msg 
fetchIfNeeded subRedditName posts =
    let 
        isThere =
            Dict.member subRedditName posts
    in
        if isThere then 
            Cmd.none 
        else 
            fetch subRedditName


redditUrl : String -> String
redditUrl route = 
    "https://www.reddit.com/r/" ++ route ++".json"


decoder : Decoder (List Post)
decoder =
    JD.at 
        ["data", "children"] 
        (JD.list decodeReddit)


decodeReddit : Decoder Post
decodeReddit =
    JD.field "data"
        ( decode Post
            |> required "title" JD.string
            |> required "url" JD.string
            |> required "author" JD.string
            |> required "score" JD.int
            |> required "created" JD.float
            |> required "num_comments" JD.int
            |> required "thumbnail" JD.string
        ) 