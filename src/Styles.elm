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
    , property "z-index" "99"
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
    , property "offset-inline-start" "0"
    ]


contentStyle : List Css.Mixin
contentStyle =
    [ all initial
    , backgroundColor (hex "fff")
    ]


wrapperStyle : List ( String, String )
wrapperStyle =
    [ ( "z-index", "999999" )
    , ( "transform", "translate(-50%, -50%)" )
    , ( "position", "fixed" )
    , ( "top", "50%" )
    , ( "left", "50%" )
    , ( "offset-inline-start", "50%" )
    ]
