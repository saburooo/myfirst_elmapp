module Tests exposing (..)
import Http exposing (Expect)
import Url
import Test exposing (Test)
import Expect
import Url.Parser
import Url.Parser exposing (Parser)
import Html exposing (a)
import Url.Parser exposing (oneOf)



type Route
    = Top
    | User String
    | Repo String String



parse : Url -> Maybe Route
parse url =
    Just Top


testParse : String -> String -> Maybe Route -> Test
testParse name path expectedRoute = 
    test name <|
        \_ ->
            Url.fromString ("http://example.com" ++ path)
                |> Maybe.andThen Route.parse
                |> Expect.equal expectedRoute



suite : Test
suite = 
    describe "Route"
        [ testParse "should parse Top" "/" (Just Route.Top)
        , testParse "should parse Top with queries" "/?dummy=value" (Just Route.Top)
        , testParse "should parse Top with hash" "/#dummy" (Just Route.Top)
        , testParse "should parse User" "/foo" (Just (Route.User "foo"))
        , testParse "should parse Repo" "/foo/bar" (Just (Route.Repo "foo" "bar"))
        , testParse "should parse invalid path" "/foo/bar/baz" Nothing
        ]


parse : Url -> Maybe Route
parse url =
    Url.Parser.parse parser url


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Top top
        , map User string
        , map Repo (string </> string)
        ]