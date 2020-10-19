module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

import Jsoon.Decode exposing (Decoder)


-- MODEL

type alias Model =
    { base : String
    , appeal : String
    }


-- UPDATE

{-
ここでJSONファイルから文章を生成したい、Reactとどっちにしようかマジで迷う・・・
-}
type Msg
    = Base
    | Appeal


update : Msg -> Model -> Model
update msg model =
    case msg of
        Base ->
            model.base

        Appeal ->
            model.appeal


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Base ] [text "基本情報"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        ]