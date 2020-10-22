module Tests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


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


suite : Test
suite =
    describe "type About -> updateAbout about"
        [ test "get string" 
            updateAbout Title
        ]
