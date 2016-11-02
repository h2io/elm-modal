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
import Html.CssHelpers
import Time exposing (second, Time)
import Task
import Task.Extra exposing (delay)


{-|
H2ioModal's Model is used to set inner content, size  and visibility. See
`modalModel` for a usage example.
-}
type alias Model =
    { visible : Bool
    , animate : AnimationController
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


type AnimationController
    = Appear
    | Leave
    | Clean


type Animations
    = Pop
    | Fade


{-|
Default model values for `H2ioModal`. Must be added in your own `model`. See
**Boilerplate** section.
-}
init : Model
init =
    { visible = False
    , animate = Clean
    }


{-|
Elm architecture Msg. **Used internally, use `show` & `close` helper functions
instead of these.**
-}
type Msg
    = NoOp
    | Close
    | ActualClose Bool
    | Show
    | Animate AnimationController


{-|
Update functions for above Msg. Must be added in your own `update`. See
**Boilerplate** section.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Close ->
            close model

        ActualClose false ->
            { model
                | visible = false
            }
                ! [ cleanUp ]

        Animate anim ->
            { model | animate = anim } ! []

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
show : Model -> ( Model, Cmd Msg )
show model =
    ({ model | visible = True, animate = Appear } ! [ cleanUpDelay ])


{-| `close` can be used to manually clean up your model when the H2ioModal closes.
-}
close : Model -> ( Model, Cmd Msg )
close model =
    { model | animate = Leave } ! [ actualClose ]


actualClose : Cmd Msg
actualClose =
    delay (0.5 * second) (Task.succeed False)
        |> Task.perform (\_ -> NoOp)
            ActualClose


cleanUp : Cmd Msg
cleanUp =
    Task.perform (\_ -> NoOp)
        Animate
        (Task.succeed Clean)


cleanUpDelay : Cmd Msg
cleanUpDelay =
    delay (0.5 * second) (Task.succeed Clean)
        |> Task.perform (\_ -> NoOp)
            Animate


animationFrom : Animations -> String
animationFrom anim =
    case anim of
        Fade ->
            "fade .2s ease"

        Pop ->
            "pop .3s cubic-bezier(0.4, 0, 0, 1.5)"


animationStyle : Animations -> AnimationController -> List ( String, String )
animationStyle anim controller =
    let
        control =
            case controller of
                Clean ->
                    ""

                Appear ->
                    animationFrom anim

                Leave ->
                    (animationFrom anim) ++ " reverse forwards"
    in
        [ ( "animation", control ) ]


content : (Msg -> msg) -> ViewModel msg -> Model -> Html msg
content fwd viewModel model =
    div
        [ styles wrapperStyle
        , style
            ([ ( "width", viewModel.width )
             , ( "height", viewModel.height )
             ]
                ++ (animationStyle Pop model.animate)
            )
        ]
        [ hover closeButtonHoverStyle
            button
            [ styles closeButtonStyle
            , onClick (fwd Close)
            ]
            [ Html.text "✖" ]
        , viewModel.content
        ]


animations : String
animations =
    """
    @keyframes fade {
      from {
          opacity:0;
      }
      to {
          opacity:1;
      }
    }
    @keyframes pop {
      from {
        transform: translate3d(-50%, 30%, 0);
        opacity: 0;
      }
      to {
        opacity: 1;
      }
    }
  """


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
            [ Html.CssHelpers.style animations
            , div
                [ styles backgroundStyle
                , style (animationStyle Fade model.animate)
                ]
                []
            , content fwd viewModel model
            ]
    else
        div [] []
