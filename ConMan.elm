module ConMan where

import Html exposing (..)
import Html.Attributes exposing (..)

main =
  view


-- VIEW

view =
  div [ class "container" ]
  [
    h1 [ ] [ text "Conman" ],
    contact "Bobby Tables" "bobby@example.com",
    contact "Molly Apples" "molly@example.com",
    contact "Elroy Bacon" "el_bacon@example.com"
  ]


contact name email =
  div [ ] [
    h2 [ ] [ text name ],
    div [ ]
    [
      label [ ] [ text "Email:" ],
      a [ href ("mailto:" ++ email) ] [ text email ]
    ]
  ]
