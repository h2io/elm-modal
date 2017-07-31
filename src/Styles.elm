module Styles exposing (..)


type alias StandardCss =
    List ( String, String )


closeButtonStyle : StandardCss
closeButtonStyle =
    [ ( "all", "initial" )
    , ( "color", "#bdc2c4" )
    , ( "position", "absolute" )
    , ( "width", "20px" )
    , ( "font-size", "20px" )
    , ( "height", "20px" )
    , ( "line-height", "22px" )
    , ( "top", "5px" )
    , ( "right", "5px" )
    , ( "cursor", "pointer" )
    , ( "padding", "0" )
    , ( "padding-left", "2px" )
    , ( "overflow", "hidden" )
    , ( "box-sizing", "border-box" )
    , ( "transition", ".2s ease color" )
    , ( "z-index", "99" )
    ]


closeButtonHoverStyle : StandardCss
closeButtonHoverStyle =
    [ ( "color", "#9aa0a3" )
    ]


backgroundStyle : StandardCss
backgroundStyle =
    [ ( "all", "initial" )
    , ( "position", "fixed" )
    , ( "background-color", "rgba(0, 0, 0, 0.8)" )
    , ( "top", "0" )
    , ( "left", "0" )
    , ( "width", "100%" )
    , ( "height", "100%" )
    , ( "z-index", "9999" )
    , ( "offset-inline-start", "0" )
    ]


contentStyle : StandardCss
contentStyle =
    [ ( "all", "initial" )
    , ( "background-color", "#fff" )
    ]


wrapperStyle : StandardCss
wrapperStyle =
    [ ( "z-index", "999999" )
    , ( "transform", "translate(-50%, -50%)" )
    , ( "position", "fixed" )
    , ( "top", "50%" )
    , ( "left", "50%" )
    , ( "offset-inline-start", "50%" )
    ]
