module Main exposing (main, Model)

import Browser
import Browser.Navigation as Nav

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

import Url

import Json.Decode as D exposing (Decoder)

import Http


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


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "自己紹介するね！！！" ]
        , viewSentence model
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
                [ button [ onClick MorePlease, style "display" "block" ] [ text "More Please!" ]
                , [ text url ] [] 
                ]



-- HTTP


getAboutJson : Cmd Msg
getAboutJson =
    Http.get
        { url = "http://127.0.0.1:8000/api/"
        , expect = Http.expectJson GotSentence aboutDecoder
        }



-- DATA


type alias About =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }


aboutDecoder : Decoder String
aboutDecoder =
    D.field "title" (D.field "name" D.string)