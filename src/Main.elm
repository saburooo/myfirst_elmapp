module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

import Jsoon.Decode exposing (Decoder)


-- MODEL

type alias Model =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }


-- UPDATE

{-
ここでJSONファイルから文章を生成したい、Reactとどっちにしようかマジで迷う・・・
-}
type Msg
    = Title
    | Name
    | Basic
    | Episode
    | Appeal
    | Email


update : Msg -> Model -> Model
update msg model =
    case msg of

        Title ->
            model.title

        Name ->
            model.name

        Basic ->
            model.basic

        Episode ->
            model.episode

        Appeal ->
            model.appeal

        Email ->
            model.email


-- VIEW

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Base ] [text "基本情報"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        ]