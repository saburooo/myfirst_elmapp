module Route exposing (Route(..), parse)

import Url exposing (Url)
import Url.Parser exposing (..)



type Route
    = Top
    | TitlePage String
    | NamePage String
    | BasicPage String
    | EpisodePage String
    | AppealPage String
    | EmailPage String


parse : Url -> Maybe Route
parse url =
    Url.Parser.parse parser url



routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Top (s "/")
        , map TitlePage string
        , map NamePage string
        , map BasicPage string
        , map EpisodePage string
        , map AppealPage string
        , map EmailPage string
        ]



