module Tests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query

import Json.Decode as D exposing (Decoder)
import Http exposing (..) 
import Json.Decode exposing (field, map6)
import Html exposing (text)
import Html.Events exposing (onInput)
import Url exposing (Url)


type About
    = Title
    | Name
    | Basic
    | Episode
    | Appeal
    | Email


type Msg
    = WaitToClickButton
    | GotSentence (Result Http.Error String)


updateAbout : About -> String
updateAbout about =
    case about of
        Title -> "title"
        
        Name -> "name"

        Basic -> "basic"

        Episode -> "episode"

        Appeal -> "appeal"

        Email -> "email"



type alias AboutJson =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }





suite : Test
suite =
    describe "type About -> updateAbout about"
        [ test "get string" <|
            \_ ->
                let
                    answer01 = "title"
                in
                    Expect.equal answer01 (updateAbout Title)
        , test "get string2" <|
            \_ ->
                let
                    answer02 = "name"
                in
                    Expect.equal answer02 (updateAbout Name)
        , test "get string3" <|
            \_ ->
                let
                    answer03 = "basic"
                in
                    Expect.equal answer03 (updateAbout Basic)
        , test "get string4" <|
            \_ ->
                let
                    answer04 = "episode"
                in
                    Expect.equal answer04 (updateAbout Episode)
        , test "get string5" <|
            \_ ->
                let
                    answer05 = "appeal"
                in
                    Expect.equal answer05 (updateAbout Appeal)
        , test "get string6" <|
            \_ ->
                let
                    answer06 = "email"
                in
                    Expect.equal answer06 (updateAbout Email)
        ]



getAboutJson : Cmd Msg
getAboutJson =
    Http.get
        { url = "http://127.0.0.1:8000/api/1"
        , expect = Http.expectJson GotSentence aboutDecoder
        }


aboutDecoder : Decoder AboutJson
aboutDecoder =
    map6 AboutJson
        (D.field "title" D.string)
        (D.field "name" D.string)
        (D.field "basic"  D.string)
        (D.field "episode" D.string)
        (D.field "appeal" D.string)
        (D.field "email" D.string)


aboutChoiceDecoder : About -> Cmd Msg
aboutChoiceDecoder about =
    case about of
        Title -> 
            (D.field "title" D.string)