module App exposing (..)

import Html exposing (div, button, text, h1, p, Html)
import Html.Events exposing (onClick)
import Html.App as App
import H2ioModal


main : Program Never
main =
    App.program
        { init = model ! []
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type alias Model =
    { modal : H2ioModal.Model
    }


type Msg
    = NoOp
    | Show
    | H2ioModal (H2ioModal.Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Show ->
            let
                ( modal, cmd ) =
                    H2ioModal.show model.modal
            in
                { model | modal = modal } ! [ Cmd.map H2ioModal cmd ]

        H2ioModal msg' ->
            let
                ( modal, cmd ) =
                    H2ioModal.update msg' model.modal
            in
                { model | modal = modal } ! [ Cmd.map H2ioModal cmd ]


modalConfig : H2ioModal.ViewModel Msg
modalConfig =
    { content = content
    , width = "340px"
    , height = "480px"
    }


model : Model
model =
    { modal = H2ioModal.init
    }


content : Html Msg
content =
    div []
        [ h1 [] [ text "Example Modal" ]
        , p [] [ text "Some content" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Show ] [ text "Show Modal" ]
        , H2ioModal.view H2ioModal modalConfig model.modal
        ]
