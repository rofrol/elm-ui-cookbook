module Main exposing (main)

import Browser
import Element exposing (..)
import Html exposing (Html)
import Html.Attributes as HtmlA
import Html.Events as HtmlE
import Html.Events.Extra exposing (targetValueIntParse)
import Json.Decode as D


type alias Flags =
    {}


type alias Model =
    { yearOfBirth : Maybe Int }


initialModel : Model
initialModel =
    { yearOfBirth = Nothing }


type Msg
    = YearOfBirthChanged Int


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


main : Program Flags Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


view : Model -> Browser.Document Msg
view model =
    let
        years =
            List.range 2000 2019 |> List.reverse
    in
    { title = "Example"
    , body =
        [ layout
            []
            (selectYoB model.yearOfBirth years |> html)
        ]
    }


selectYoB : Maybe Int -> List Int -> Html Msg
selectYoB maybeYearOfBirth years =
    Html.select
        [ HtmlE.on "change" (D.map YearOfBirthChanged targetValueIntParse)
        , HtmlA.style "appearance" "none"
        , HtmlA.style "-webkit-appearance" "none"
        , HtmlA.style "-moz-appearance" "none"
        , HtmlA.style "padding" "5px"
        , HtmlA.style "border-width" "0"
        , HtmlA.style "height" "48px"
        , HtmlA.style "font-size" "18px"
        , HtmlA.style "background-color" "transparent"
        ]
        (Html.option [ HtmlA.value "" ] [ Html.text "Select year" ]
            :: List.map (optionYoB maybeYearOfBirth) years
        )


optionYoB maybeYearOfBirth year =
    Html.option
        ([ HtmlA.value (String.fromInt year) ]
            ++ (case maybeYearOfBirth of
                    Nothing ->
                        []

                    Just yearOfBirth ->
                        [ HtmlA.selected (yearOfBirth == year) ]
               )
        )
        [ Html.text (String.fromInt year) ]


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        YearOfBirthChanged yearOfBirth ->
            ( { model | yearOfBirth = Just yearOfBirth }
            , Cmd.none
            )
