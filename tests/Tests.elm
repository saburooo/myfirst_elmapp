module Tests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)

import Json.Decode as D exposing (Decoder)


type About
    = Title
    | Name
    | Basic
    | Episode
    | Appeal
    | Email



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
    { "title" : "釣り"
    , "name" : "濱口優"
    , "basic" : "よゐこのツッコミ担当"
    , "episode" : "京都での仕事に「いろいろあって遅れてしまった」という濱口は、相方・有野晋哉（48）から「お前、はよ来いや！」と電話があったと回想。その後、大坂から慌てて出発した濱口は、「京都に向かうんですけど、向かってたどり着いたらなぜか奈良だったんですよ」"
    , "appeal" : "モリ突きができます"
    , "email" : "hamaguchi@masaru.com" 
    }



aboutDecoder : String -> Decoder String
aboutDecoder aboutstr =
    D.field aboutstr D.string



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
        , todo "Jsonから値を取り出せるか？"
        ]