module About exposing (..)

import Json.Decode as D exposing (Decoder, field, string, map, map6, decodeString)


-- MODEL


type About 
    = Title
    | Name
    | Basic
    | Episode
    | Appeal
    | Email



type State
    = Failure Http.Error
    | Waiting
    | Loaded AboutJson




-- UPDATE



type Msg
    = GotWaiting
    | GotSentence (Result Http.Error AboutJson)



aboutUpdate : Msg -> Model -> (Model, Cmd Msg)
aboutUpdate msg model =
  case msg of
    GotWaiting ->
        (model, getAboutJson)

    GotSentence result ->
        case result of
            Ok url ->
                ( { model | state = Loaded url }, Cmd.none)

            Err e ->
                ( { model | state = Failure e }, Cmd.none)




aboutToString : About -> String
aboutToString about =
    case about of
        Title -> "title"
        
        Name -> "name"

        Basic -> "basic"

        Episode -> "episode"

        Appeal -> "appeal"

        Email -> "email"



-- HTTP


getAboutJson : Cmd Msg
getAboutJson =
    Http.get
        { url = "http://127.0.0.1:8000/api/1?format=json"
        , expect = Http.expectJson GotSentence aboutDecoder
        }



-- DATA


aboutDecoder : Decoder AboutJson
aboutDecoder =
    map6 AboutJson
        (field "title" string)
        (field "name" string)
        (field "basic" string)
        (field "episode" string)
        (field "appeal" string)
        (field "email" string)




type alias AboutJson =
    { title : String
    , name : String
    , basic : String
    , episode : String
    , appeal : String
    , email : String
    }
