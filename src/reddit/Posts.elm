module Reddit.Posts exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, src)
import Http 
import Json.Decode as JD exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import List
import Dict 
import Date exposing (Date)
import Date.Distance as Distance

import Models exposing (Post, Posts, Model)
import Messages exposing (Msg(..))







view : Model -> Html Msg
view {posts, selected, now} =
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
                    , ul [ class "post-list"] (List.map (redditPostView now) rx) 
                    ]


redditPostView : Date -> Post -> Html Msg
redditPostView now r =
    li [ class "post"] 
        [ div [ class "post-meta"] 
            [ span [ class "post-author"]
                [ text "by "
                , a [ href <| "https://www.reddit.com/user/" ++ r.author] [text r.author]
                ]
            , span [ class "post-created"] 
                [ text "submitted"
                , text " "
                , text <| Distance.inWords r.created now
                , text " "
                , text "ago"
                ]
            ]
        , scoreView r.score
        , a 
            [ href r.url
            , class "post-url"
            ]
            [ thumbnailView r.thumbnail
            , h3 [ class "post-title"] [text r.title]
            ]
        , div [ class "past-numcomments"]
            [ text "Comments: "
            , text <| toString r.numComments
            ]
        ]


thumbnailView : String -> Html Msg
thumbnailView thumbnail =
    if thumbnail /= "self" then 
        img 
            [ src thumbnail
            , class "post-thumbnail"
            ] []
    else 
        text ""

scoreView : Int -> Html Msg
scoreView score =
    let
        stringScore =
            if score < 1000 then
                toString score
            else
                toString (score // 1000) ++ "." ++ (String.left 1 << toString << (%) score) 1000 ++ "k"
            
    in
        div [ class "post-score"]
            [ i [ class "fa fa-arrow-up"] []
            , span [] [ text stringScore ]
            , i [ class "fa fa-arrow-down"] []
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
            |> required "created" decodeDate
            |> required "num_comments" JD.int
            |> required "thumbnail" JD.string
        ) 


decodeDate : Decoder Date.Date
decodeDate =
    JD.float
        |> JD.map (\t -> t*1000) -- Reddit uses Unix Timestamps
        |> JD.map Date.fromTime
