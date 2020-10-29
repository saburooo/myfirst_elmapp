module TestRoute exposing (..)

import Url exposing (Url)
import Test exposing (Test)
import Test exposing (describe)
import Test exposing (test)
import Url.Parser exposing (Parser, (</>), map, oneOf, s, string)
import Http exposing (Expect)
import Expect
import Url.Parser exposing (parse)

import Test.Html.Event as HtEvent




-- MODEL

type alias Model =
    { route : Route
    }



type Route
    = Top
    | TitlePage String
    | NamePage String
    | BasicPage String
    | EpisodePage String
    | AppealPage String
    | EmailPage String




routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Top (s "/")
        , map TitlePage (s "title" </> string)
        , map NamePage (s "name" </> string)
        , map BasicPage (s "base" </> string)
        , map EpisodePage (s "episode" </> string)
        , map AppealPage (s "appeal" </> string)
        , map EmailPage (s "email" </> string)
        ]


