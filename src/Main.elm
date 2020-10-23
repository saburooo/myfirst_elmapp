module Main exposing (main, Model)

import Browser
import Browser.Navigation as Nav

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Url

import Json.Decode as D exposing (Decoder)

import Http
import Test.Internal exposing (toString)


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

type Model
    = Failure
    | Loading
    | Success String




init : () -> (Model, Cmd Msg)
init _ =
    ( Loading
    , getAboutJson
    )



-- UPDATE


type Msg
    = MorePlease
    | GotSentence (Result Http.Error String)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
        (Loading, getAboutJson)

    GotSentence result ->
        case result of
            Ok url ->
                (Success url, Cmd.none)

            Err _ ->
                (Failure, Cmd.none)


updateAbout : About -> String
updateAbout about =
    case about of
        title -> "title"
        
        name -> "name"

        basic -> "basic"

        episode -> "episode"

        appeal -> "appeal"

        email -> "email"




-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- VIEW


view : Model -> About -> Html Msg
view model about =
    div []
        [ h2 [] [ text "自己紹介するね！！！" ]
        , button [ onClick Title ] [ text "タイトル" ]
        , button [ onClick Name ] [ text "お名前" ]
        , button [ onClick Basic ] [ text "基本情報" ]
        , button [ onClick Episode ] [ text "エピソード" ]
        , button [ onClick Appeal ] [ text "アピールポイント" ]
        , button [ onClick Email ] [ text "メールアドレス" ]
        , div [] [ text (toString about )]
        ]



viewSentence : Model -> Html Msg
viewSentence model =
    case model of
        Failure ->
            div []
                [ text "スマヌ、ミツカラナカッタ"
                , button [ onClick MorePlease ] [ text "もっかいやる" ]
                ]
        
        Loading ->
            text "Loading"
        
        Success url ->
            div []
                [ button [ onClick MorePlease ] [ text "More Please!" ]
                ]



-- HTTP


getAboutJson : Cmd Msg
getAboutJson =
    Http.get
        { url = "http://127.0.0.1:8000/api/"
        , expect = Http.expectJson GotSentence
        }



-- DATA


type About 
    = Title String
    | Name String
    | Basic String
    | Episode String
    | Appeal String
    | Email String

