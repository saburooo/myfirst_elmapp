module TestRoute exposing (suite)

import Expect exposing (..)
import Fuzz exposing (..)
import Route exposing (Route)
import Test exposing (..)
import Url


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
        , testParse "should parse TitlePage" "/title" (Just (Route.TitlePage "title"))
        , testParse "should parse NamePage" "/name" (Just (Route.NamePage "name"))
        , testParse "should parse BasicPage" "/basic" (Just (Route.BasicPage "base"))
        , testParse "should parse EpisodePage" "/episode" (Just (Route.EpisodePage "episode"))
        , testParse "should parse AppealPage" "/appeal" (Just (Route.AppealPage "appeal"))
        , testParse "should parse EmailPage" "/email" (Just (Route.AppealPage "email"))
        , testParse "should parse invalid path" "/foo/bar/baz" Nothing
        ]
 
