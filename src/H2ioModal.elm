module H2ioModal exposing (Model, Msg(Show, Close), view, modalModel, update)

{-|
A Modal UI component written in Elm

# Usage
H2ioModal exports a component written in The Elm Architecture, so you can easily
start using it. It is recommended that you import it exposing `modalModel`,
a default version of it's Model.

## Boilerplate

# Exposed Parts
@docs Model, modalModel, Msg, update, view
-}

import Html exposing (div, button, Html)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Html.App as App
import Css exposing (..)


{-|
H2ioModal's Model is used to set inner content, size  and visibility. See
`modalModel` for a usage example.
-}
type alias Model =
    { content : Html Msg
    , width : String
    , height : String
    , visible : Bool
    }


{-|
modalModel is an initial Model that get's exported for easier manipulation. You
can see a commented implementation in the example folder. Basically, you import
`modalModel`, destructure it and add your own elements to it, before setting it
in the application's Model.

    modalConfig : H2ioModal.Model
    modalConfig =
        { modalModel
            | content = content --`content` has to have a `Html H2ioModal.Msg` type.
            , width = "340px"
            , height = "480px"
        }


    model : Model
    model =
        { modal = modalConfig
        ,  ...
        }
-}
modalModel : Model
modalModel =
    { content = div [] []
    , width = "300px"
    , height = "300px"
    , visible = False
    }


init : ( Model, Cmd Msg )
init =
    modalModel ! []


{-|
Elm architecture Msg. Besides the generic `Msg` being exposed, `Show` and
`Close` are directly available for you to use.

The exposed `Show` is the recommended way of toggling the visibility of the H2ioModal.

    update msg model =
        case msg of
            ...
            Show ->
                let
                    modal' =
                        H2ioModal.update H2ioModal.Show model.modal
                in
                    { model | modal = modal' } ! []

    --in your view
    button [ onClick Show ] [ text "Show Modal" ]


The exposed `Close` can be used to manually clean up your model when the H2ioModal closes.
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
            { model | visible = False }

        Show ->
            { model | visible = True }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


styles : List Css.Mixin -> Html.Attribute Msg
styles =
    Css.asPairs >> style


closeButtonStyle : List Css.Mixin
closeButtonStyle =
    [ all initial
    , color (hex "bdc2c4")
    , position absolute
    , width (px 20)
    , height (px 20)
    , top (px 5)
    , right (px 5)
    , cursor pointer
    , padding zero
    , overflow hidden
    , boxSizing borderBox
    , before
        [ lineHeight (px 22)
        , fontSize (px 20)
        , textAlign center
        , marginLeft zero
        , marginRight (px 32)
        , paddingLeft (px 2)
        ]
    ]


backgroundStyle : List Css.Mixin
backgroundStyle =
    [ all initial
    , position fixed
    , backgroundColor (rgba 0 0 0 0.8)
    , top zero
    , left zero
    , width (pct 100)
    , height (pct 100)
    ]


contentStyle : List Css.Mixin
contentStyle =
    [ all initial
    , backgroundColor (hex "fff")
    ]


wrapperStyle : List Css.Mixin
wrapperStyle =
    [ all initial
    , backgroundColor (hex "fff")
    , display block
    , position fixed
    , top (pct 50)
    , left (pct 50)
    , padding (px 10)
    ]


background : Html Msg
background =
    div [ styles backgroundStyle ] []


content : Model -> Html Msg
content model =
    div
        [ styles wrapperStyle
        , style
            [ ( "zIndex", "2" )
            , ( "background"
              , """
              linear-gradient(135deg, transparent 20px, #fff 0) top left,
              linear-gradient(225deg, #fff 10px, #fff 0) top right,
              linear-gradient(315deg, transparent 20px, #fff 0) bottom right,
              linear-gradient(45deg,  #fff 10px, #fff 0) bottom left
              """
              )
            , ( "background-size", "50%" )
            , ( "background-repeat", "no-repeat" )
            , ( "transform", "translate(-50%, -50%)" )
            , ( "transition", "transform .3s cubic-bezier(0.4, 0, 0, 1.5)" )
            , ( "width", model.width )
            , ( "height", model.height )
            ]
        ]
        [ button
            [ styles closeButtonStyle
            , style [ ( "transition", ".2s ease color" ) ]
            , onClick Close
            ]
            [ Html.text "✖" ]
        , model.content
        ]


{-|
Elm architecture view. Use it with Html.App.Map in your application.
-}
view : Model -> Html Msg
view model =
    if model.visible then
        div []
            [ background
            , content model
            ]
    else
        div [] []


main : Program Never
main =
    App.beginnerProgram
        { model = modalModel
        , view = view
        , update = update
        }



-- App.program
--     { init = init
--     , view = view
--     , update = update
--     , subscriptions = subscriptions
--     }
