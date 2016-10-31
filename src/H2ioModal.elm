module H2ioModal
    exposing
        ( Model
        , ViewModel
        , Msg(Close)
        , view
        , init
        , update
        , show
        , close
        )

{-|
A Modal UI component written in Elm

# Usage
H2ioModal exports a component written in The Elm Architecture, so you can easily
start using it.

## Boilerplate

# Exposed Parts
@docs Model, ViewModel, show, close, view, init, Msg, update

-}

import Html exposing (div, button, Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Styles exposing (..)
import InlineHover exposing (hover)


{-|
H2ioModal's Model is used to set inner content, size  and visibility. See
`modalModel` for a usage example.
-}
type alias Model =
    { visible : Bool
    }


{-|
ViewModel is your modal's configuration. This will define the inside of the
modal and the size. The inside view (`content`) can be as complex as you want it
to be. The `ViewModel` will be given to the `view` function, see **view** for usage.

    modalConfig : H2ioModal.ViewModel Msg
    modalConfig =
        { content = yourOwnContentHere
        , width = "340px"
        , height = "480px"
        }
-}
type alias ViewModel msg =
    { content : Html msg
    , width : String
    , height : String
    }


{-|
Default model values for `H2ioModal`. Must be added in your own `model`. See
**Boilerplate** section.
-}
init : Model
init =
    { visible = False
    }


{-|
Elm architecture Msg. **Used internally, use `show` & `close` helper functions
instead of these.**
-}
type Msg
    = NoOp
    | Close
    | Show


{-|
Update functions for above Msg. Must be added in your own `update`. See
**Boilerplate** section.
-}
update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Close ->
            close model

        Show ->
            show model


{-|
   `show` is the recommended way of toggling the visibility of the H2ioModal.

       update msg model =
           case msg of
               ...
               Show ->
                   { model | modal = H2ioModal.show model.modal } ! []

    and in your view

       button [ onClick Show ] [ text "Show Modal" ]
-}
show : Model -> Model
show model =
    { model | visible = True }


{-| `close` can be used to manually clean up your model when the H2ioModal closes.
-}
close : Model -> Model
close model =
    { model | visible = False }


content : (Msg -> msg) -> ViewModel msg -> Model -> Html msg
content fwd viewModel model =
    div
        [ styles wrapperStyle
        , style
            [ ( "width", viewModel.width )
            , ( "height", viewModel.height )
            ]
        ]
        [ hover closeButtonHoverStyle
            button
            [ styles closeButtonStyle
            , onClick (fwd Close)
            ]
            [ Html.text "✖" ]
        , viewModel.content
        ]


{-|
Renders the modal with a given configuration. No need to use `Html.App.map`

    div []
        [ ...
        , H2ioModal.view H2ioModal modalConfig model.modal
        ]
-}
view : (Msg -> msg) -> ViewModel msg -> Model -> Html msg
view fwd viewModel model =
    if model.visible then
        div []
            [ div [ styles backgroundStyle ] []
            , content fwd viewModel model
            ]
    else
        div [] []
