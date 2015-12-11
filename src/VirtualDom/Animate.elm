module VirtualDom.Animate (animatedAttribute, animatedStyle) where

{-|

# CSS Animation
@docs animatedAttribute, animatedStyle

-}

import String
import Html exposing (Attribute)

import Native.VirtualDom.Animate


{-| An attribute that has its initial value set, and then when added to the page, has its final value set. This allows
for easy and consistent CSS animation.

For example, assuming a stylesheet with a 'transition' class containing 'transition: background-color 1s;', a 'white'
class containing 'background-color: #ffffff;' and a 'black' class containing 'background-color: #000000;':

    import Html exposing (div, text)
    import VirtualDom.Animate exposing (animatedAttribute)

    main = div [ animatedAttribute "class" "transition white" "transition black" ] [ text "Fade from white to black." ]

-}
animatedAttribute : String -> String -> String -> Attribute
animatedAttribute name initial final =
  Native.VirtualDom.Animate.animatedAttribute name initial final


{-| A style that has its initial value set, and then when added to the page, has its final value set. This allows
for easy and consistent CSS animation.

Generally it is best to put your styles in a stylesheet, but sometimes to generate content it is required to add them
live.

For example, assuming a stylesheet with a 'transition' class containing 'transition: background-color 1s;':

    import Html exposing (div, text)
    import Html.Attributes exposing (class)
    import VirtualDom.Animate exposing (animatedStyle)

    main = div
      [ class "transition"
      , animatedStyle [ ("background-color", "#ffffff") ] [ ("background-color", "#000000") ]
      ]
      [ text "Fade from white to black." ]

-}
animatedStyle : List (String, String) -> List (String, String) -> Attribute
animatedStyle initialStyle finalStyle =
  animatedAttribute "style" (styleValue initialStyle) (styleValue finalStyle)


styleValue : List (String, String) -> String
styleValue styles
  = styles
    |> List.map (\(key,value) -> (key ++ ": " ++ value))
    |> String.join "; "
