module Test exposing (main, Model)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

import Json.Decode exposing (Decoder, field, string, map6)


-- MAIN
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL

type alias Model =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }


aboutDecoder:Decoder Model
aboutDecoder =
    map6 Model
        (field "title" string)
        (field "name" string)
        (field "basic" string)
        (field "episode" string)
        (field "email" string)



type Model
    = Failure
    | Loading
    | Success String



init:() -> (Model, Cmd Msg)
init _ =
    (Loading getJsonSentence)


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
        [ button [ onClick Title ] [text "どうも"]
        , button [ onClick Name ] [text "お名前"]
        , button [ onClick Basic ] [text "基本情報"]
        , button [ onClick Episode ] [text "エピソード"]
        , button [ onClick Appeal ] [text "アピールポイント"]
        , button [ onClick Email ] [text "メールアドレス"]
        ]


-- HTTP


getSentence:Cmd Msg