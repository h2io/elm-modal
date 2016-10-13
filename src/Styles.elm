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
