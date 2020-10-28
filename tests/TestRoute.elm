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
    | User String
    | Repo String String



type UrlAbout 
    = UrlTitle String
    | UrlName String
    | UrlBasic String
    | UrlEpisode String
    | UrlAppeal String
    | UrlEmail String




routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map User  (s "user" </> string)
        , map Repo  (s "user" </> string </> s "repo" </> string)
        ]





suite : Test
suite =
    describe "URLのパースをテストできるのか"
        [ test "トップ" <|
            \_ ->
                Url.fromString "http://localhost.com/"
                    |> Maybe.andThen parse 
                    |> Expect.equal (Just Top)
        ]
