module TestRoute exposing (..)

import Url exposing (Url)
import Test exposing (Test)
import Test exposing (describe)
import Test exposing (test)
import Url.Parser exposing (Parser, (</>), map, oneOf, s, string)
import Http exposing (Expect)
import Expect
import Url.Parser exposing (parse)



-- MODEL

type Route
    = Top
    | UrlTitle String
    | UrlName String
    | UrlBasic String
    | UrlEpisode String
    | UrlAppeal String
    | UrlEmail String




routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Top top
        , map UrlTitle (s "title")
        ]





suite : Test
suite =
    describe "URLのパースをテストできるのか"
        [ test "トップ" <|
            \_ ->
                Url.fromString "http://localhost.com/"
                    |> Maybe.andThen parse
                    |> Expect.equal (Result.Ok)
        ]
