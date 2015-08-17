module ConMan where

import Html exposing (..)
import Html.Attributes exposing (..)

main =
  view


-- MODEL

newContact name email phone =
  { name = name,
    email = email,
    phone = phone
  }


-- VIEW

view =
  div [ class "container" ]
  [
    h1 [ ] [ text "Conman" ],
    contactList
  ]


contactList =
  ul [ class "contact-list" ]
  [ contact (newContact "Bobby Tables" "bobby@example.com"    "01 234 5678"),
    contact (newContact "Molly Apples" "molly@example.com"    "01 789 2340"),
    contact (newContact "Elroy Bacon"  "el_bacon@example.com" "01 398 7654")
  ]


contact contact =
  li [ class "contact-list__contact" ] [
    h2 [ class "contact-list__contact__name" ] [ text contact.name ],
    div [ class "contact-list__contact__email" ]
    [
      label [ ] [ text "Email:" ],
      a [ href ("mailto:" ++ contact.email) ] [ text contact.email ]
    ],
    div [ class "contact-list__contact__phone" ]
    [
      label [ ] [ text "Phone:" ],
      a [ href ("tel:" ++ contact.phone) ] [ text contact.phone ]
    ]
  ]
