module Main exposing (main, Model)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Json.Decode exposing (Decoder, field, string, map6)
import Http


-- MAIN
main : Program () Model Msg
main =
    Browser.application 
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }


-- MODEL

type alias About =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }



type Model
    = Failure
    | Loading
    | Success String



init:() -> (Model, Cmd Msg, About)
init _ =
    (Loading getJsonSentence "")



-- UPDATE

{-
ここでJSONファイルから文章を生成したい、
-}
type Msg
    = Title
    | Name
    | Basic
    | Episode
    | Appeal
    | Email




update : Msg -> About -> About
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
        [ button [ onClick Title ] [text "どうも"]
        , button [ onClick Name ] [text "お名前"]
        , button [ onClick Basic ] [text "基本情報"]
        , button [ onClick Episode ] [text "エピソード"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        , button [ onClick Email ] [text "メールアドレス"]
        , p [] [text getSentence Msg ]
        ]


-- HTTP


getSentence: Cmd Msg
getSentence =
    Http.get
        { url = "http://localhost:8000/api/?format=1"
        , expect = Http.expectJson aboutDecoder
        }


aboutDecoder:Decoder About
aboutDecoder =
    map6 Model
        (field "title" string)
        (field "name" string)
        (field "basic" string)
        (field "episode" string)
        (field "email" string)

