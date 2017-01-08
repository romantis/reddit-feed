port module Ports exposing (..)

import Models exposing (SubReddit)

port setStorage :  List SubReddit -> Cmd msg 