module App exposing (..)

import Html exposing (div, button, text, h1, p, Html)
import Html.Events exposing (onClick)
import Html.App as App
import Modal exposing (modalModel)


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
    { modal : Modal.Model
    }


type Msg
    = NoOp
    | Show
    | ModalMsg (Modal.Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        {--`Show` manually sends `Modal.update` the `Show Msg` so you don't
            handle more complex actions in your own app. Also, in this way you
            may add your own `model` modifications here as well.
            `Modal.Close` is also exposed, in case you want to clean up your
            own model after the `Modal` closed
        --}
        Show ->
            let
                modal' =
                    Modal.update Modal.Show model.modal
            in
                { model | modal = modal' } ! []

        ModalMsg msg' ->
            let
                modal' =
                    Modal.update msg' model.modal
            in
                { model | modal = modal' } ! []



{--modalConfig takes the modal's model and just adds the custom values
    necessary for your app. `content` should always be set by you.
    `modalModel` is exposed in the import because the compiler has issues
    destructuring capitalized records.
--}


modalConfig : Modal.Model
modalConfig =
    { modalModel
        | content = content
        , width = "340px"
        , height = "480px"
    }


model : Model
model =
    { modal = modalConfig
    }



{--Because the content will be passed down to the Modal, it has to have a
    `Html Modal.Msg` type instead of an often used `Html Msg` type.
--}


content : Html Modal.Msg
content =
    div []
        [ h1 [] [ text "Example Modal" ]
        , p [] [ text "Some content" ]
        ]


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Show ] [ text "Show Modal" ]
        , Modal.view model.modal |> App.map ModalMsg
        ]
