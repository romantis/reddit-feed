module Shared.Helpers exposing (..)

import Html exposing (Attribute)
import Html.Events exposing (onWithOptions, defaultOptions, keyCode, on)
import Json.Decode as Json exposing (succeed)

hrefClick : (String -> msg) -> String -> Attribute msg
hrefClick msg url =
    onWithOptions 
        "click"  
        {defaultOptions | preventDefault = True }
        (succeed (msg url))


onEnter : msg -> Attribute msg
onEnter msg =
    let
        isEnter code =
            if code == 13 then
                Json.succeed msg
            else
                Json.fail "not ENTER"
    in
        on "keydown" (Json.andThen isEnter keyCode)


(=>) : a -> b -> ( a, b )
(=>) = (,)