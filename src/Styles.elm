module Styles exposing (..)

import Css exposing (..)
import Html
import Html.Attributes exposing (style)


styles : List Css.Mixin -> Html.Attribute msg
styles =
    Css.asPairs >> style


closeButtonStyle : List Css.Mixin
closeButtonStyle =
    [ all initial
    , color (hex "bdc2c4")
    , position absolute
    , width (px 20)
    , fontSize (px 20)
    , height (px 20)
    , lineHeight (px 22)
    , top (px 5)
    , right (px 5)
    , cursor pointer
    , padding zero
    , paddingLeft (px 2)
    , overflow hidden
    , boxSizing borderBox
    , property "transition" ".2s ease color"
    ]


closeButtonHoverStyle : List ( String, String )
closeButtonHoverStyle =
    [ ( "color", "#9aa0a3" )
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
    , property "z-index" "9999"
    ]


contentStyle : List Css.Mixin
contentStyle =
    [ all initial
    , backgroundColor (hex "fff")
    ]


wrapperStyle : List Css.Mixin
wrapperStyle =
    [ property "all" "initial"
    , backgroundColor (hex "fff")
    , display block
    , position fixed
    , top (pct 50)
    , left (pct 50)
    , padding (px 10)
    , property "z-index" "99999"
    , property "background"
        """
        linear-gradient(135deg, transparent 20px, #fff 0) top left,
        linear-gradient(225deg, #fff 10px, #fff 0) top right,
        linear-gradient(315deg, transparent 20px, #fff 0) bottom right,
        linear-gradient(45deg,  #fff 10px, #fff 0) bottom left
        """
    , property "background-size" "50% 50%"
    , property "background-repeat" "no-repeat"
    , property "transform" "translate(-50%, -50%)"
    , property "offset-inline-start" "50%"
    ]
