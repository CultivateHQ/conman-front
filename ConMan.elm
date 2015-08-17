module ConMan where

import Html exposing (..)
import Html.Attributes exposing (..)

main =
  view initialModel


-- MODEL

newContact name email phone =
  { name = name,
    email = email,
    phone = phone
  }


initialModel =
  { contacts =
      [ newContact "Bobby Tables" "bobby@example.com"    "01 234 5678",
        newContact "Molly Apples" "molly@example.com"    "01 789 2340",
        newContact "Elroy Bacon"  "el_bacon@example.com" "01 398 7654"
      ]
  }


-- VIEW

view model =
  div [ class "container" ]
  [ h1 [ ] [ text "Conman" ],
    contactList model.contacts
  ]


contactList contacts =
  ul [ class "contact-list" ] (List.map contactListItem contacts)


contactListItem contact =
  li [ class "contact-list__contact" ]
  [ h2 [ class "contact-list__contact__name" ] [ text contact.name ],
    div [ class "contact-list__contact__email" ]
    [ span [ ] [ text "Email:" ],
      a [ href ("mailto:" ++ contact.email) ] [ text contact.email ]
    ],
    div [ class "contact-list__contact__phone" ]
    [ span [ ] [ text "Phone:" ],
      a [ href ("tel:" ++ contact.phone) ] [ text contact.phone ]
    ]
  ]
