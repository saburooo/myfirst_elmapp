module Main exposing (main, Model)

import Browser
import Browser.Navigation as Nav

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)

import Url

import Json.Decode as D exposing (Decoder, field, string, map, map6, decodeString)

import Http
import Url exposing (toString)

import Svg
import Svg.Attributes as Attribute
import Html.Attributes exposing (width)
import Html.Attributes exposing (height)
import Html.Attributes exposing (src)

-- MAIN
main : Program () Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


-- MODEL

type alias Model =
    { about : About
    , state : State
    }


type State
    = Failure Http.Error
    | Waiting
    | Loaded AboutJson


type About 
    = Title
    | Name
    | Basic
    | Episode
    | Appeal
    | Email



init : () -> (Model, Cmd Msg)
init _ =
    ( Model Title Waiting , getAboutJson )



-- UPDATE


type Msg
    = GotWaiting
    | GotSentence (Result Http.Error AboutJson)
-- ここにAboutと同じ型を導入したらどうかな？




update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotWaiting ->
        (model, getAboutJson)

    GotSentence result ->
        case result of
            Ok url ->
                ( { model | state = Loaded url }, Cmd.none)

            Err e ->
                ( { model | state = Failure e }, Cmd.none)



updateAbout : About -> String
updateAbout about =
    case about of
        Title -> "title"
        
        Name -> "name"

        Basic -> "basic"

        Episode -> "episode"

        Appeal -> "appeal"

        Email -> "email"




-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- VIEW


view : Model -> Html Msg
view model =
    div [ class "center-title" ]
        [ h1 [] [ text "自己紹介するね" ]
        , viewSentence model
        ]




viewSentence : Model -> Html Msg
viewSentence model =
    case model.state of
        Waiting ->
            div []
                [ h6 [] [ text "待っててください" ]
                , p [] [ text "ローディングアニメーション入れるとかさ" ]
                ]
        
        Failure error ->
            let
                _ = Debug.log "model" model
            in
                div [ class "base_ly" ]
                    [ h2 [] [ text "タイトル"]
                    , p [] [ text ("名前：" ++ (Debug.toString error)) ] 
                    , h2 [] [ text "タイトル"]
                    , p [] [ text ("名前：" ++ (Debug.toString error)) ] 
                    , h2 [] [ text "タイトル"]
                    , p [] [ text ("名前：" ++ (Debug.toString error)) ] 
                    , h2 [] [ text "タイトル"]
                    , p [] [ text ("名前：" ++ (Debug.toString error)) ] 
                    , h2 [] [ text "タイトル"]
                    , p [] [ text ("名前：" ++ (Debug.toString error)) ] 
                    , h2 [] [ text "タイトル"]
                    , p [] [ text ("名前：" ++ (Debug.toString error)) ] 
                    ]

        Loaded about ->
            div [ class "base_ly"]
                [ Html.img [ src "http://placehold.it/640x340/27709b/ffffff" ] []
                , h2 [] [ text about.title ]
                , p [] [ text ("名前：" ++ about.name) ]
                , h2 [] [ text "基本情報" ]
                , p [] [ text about.basic ]
                , h2 [] [ text "エピソード" ]
                , p [] [ text about.episode ]
                , h2 [] [ text "アピールポイント" ]
                , p [] [ text about.appeal ]
                , h2 [] [ text "Eメール" ]
                , p [] [ text about.email ]
                ]

{-
                [ button [ onClick model.about ] [ text "題名" ]
                , button [ onClick model.about ] [ text "名前" ]
                , button [ onClick model.about ] [ text "基本" ]
                , button [ onClick model.about ] [ text "エピソード" ]
                , button [ onClick model.about ] [ text "アピール" ]
                , button [ onClick model.about ] [ text "Eメール" ]
                ]
-} 
    
-- HTTP


getAboutJson : Cmd Msg
getAboutJson =
    Http.get
        { url = "http://127.0.0.1:8000/api/1?format=json"
        , expect = Http.expectJson GotSentence aboutDecoder
        }


{-
About を受け取って Cmd Msgを返す関数を定義すればいいんじゃね？
-}

-- DATA


aboutDecoder : Decoder AboutJson
aboutDecoder =
    map6 AboutJson
        (field "title" string)
        (field "name" string)
        (field "basic" string)
        (field "episode" string)
        (field "appeal" string)
        (field "email" string)




type alias AboutJson =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }
