# Building ConMan

## 1. Initial commit

  1. `md conman`
  2. `cd conman`
  3. `elm package install`
  4. `touch ConMan.elm`
  5. `open ConMan.elm`
  6. Write

      ```elm
      module ConMan where

      import Html

      main =
        Html.text "Hello, world"
      ```

  7. `elm package install evancz/elm-html 3.0.0`
  8. Add an `index.html` file with the following in it.

      ```html
      <!DOCTYPE html>
      <html>
        <head>
          <title>ConMan - Contact Manager</title>
          <script src="scripts/conman.js"></script>
        </head>
        <body>
          <script type="text/javascript">
            var app = Elm.fullscreen(Elm.ConMan);
          </script>
        </body>
      </html>
      ```

  9. `elm make --output scripts/conman.js ConMan.elm`
  10. Now run a simple web server on the root of the project (i.e. `python -m SimpleHTTPServer`) and point your browser at [http://localhost:8000](http://localhost:8000) (or wherever your server is running).
  11. If you're using git (or similar) then be sure to

      ```bash
      git init
      echo elm-stuff > .gitignore
      git add .
      git commit -m "Initial commit"
      ```


## 2. Introducing Views

  1. Change the code to

      ```elm
      module ConMan where

      import Html

      main =
        view


      -- VIEW

      view =
        Html.text "Hello, world"
      ```


## 3. Introducing Elm HTML

  1. Change the View code to look like the following

      ```elm
      module ConMan where

      import Html
      import Html.Attributes

      main =
        view


      -- VIEW

      view =
        Html.div [ Html.Attributes.class "container" ]
        [
          Html.h1 [ ] [ Html.text "Conman" ]
        ]
      ```

  2. Getting a bit tedious now to add the Html and Html.Attributes calls everywhere. Going to start getting noisy, so let's clean that up.

      ```elm
      module ConMan where

      import Html exposing (div, h1, text)
      import Html.Attributes exposing (class)

      main =
        view


      -- VIEW

      view =
        div [ class "container" ]
        [
          h1 [ ] [ text "Conman" ]
        ]
      ```

  3. We don't want to have to call out every Html element or attribute though, so we can do better than this

      ```elm
      import Html exposing (..)
      import Html.Attributes exposing (..)
      ```


## 4. Adding a contact View

  1. Change the View to the following

      ```elm
      view =
        div [ ]
        [
          h1 [ ] [ text "Conman" ],

          h2 [ ] [ text "Bobby Tables" ],
          div [ ]
          [
            label [ ] [ text "Email:" ],
            a [ href "mailto:bobby@example.com" ] [ text "bobby@example.com" ]
          ]
        ]
      ```

  2. This is fine whilst we only have one contact, but it's going to start getting messy pretty soon. Let's start by extracting a contact View.

      ```elm
      view =
        div [ class "container" ]
        [
          h1 [ ] [ text "Conman" ],
          contact
        ]


      contact =
        div [ ] [
          h2 [ ] [ text "Bobby Tables" ],
          div [ ]
          [
            label [ ] [ text "Email:" ],
            a [ href "mailto:bobby@example.com" ] [ text "bobby@example.com" ]
          ]
        ]
      ```

  3. Now let's pass in the contact details so that we can re-use the contact View

      ```elm
      view =
        div [ class "container" ]
        [
          h1 [ ] [ text "Conman" ],
          contact "Bobby Tables" "bobby@example.com"
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
      ```

  4. And now let's re-use the contact View

      ```elm
      view =
        div [ class "container" ]
        [
          h1 [ ] [ text "Conman" ],
          contact "Bobby Tables" "bobby@example.com",
          contact "Molly Apples" "molly@example.com",
          contact "Elroy Bacon" "el_bacon@example.com"
        ]
      ```


## 5. Adding a contact Model

  1. Rather than pass a disconnected name and email to the contact View, let's create the concept of a contact Model. Ad the following between the main function and the View code (it can go anywhere but this is convention).

      ```elm
      main =
        view


      -- MODEL

      newContact name email =
        { name = name,
          email = email
        }

      -- VIEW
      ```

  2. And now it can be used in the View code

      ```elm
      view =
        div [ class "container" ]
        [
          h1 [ ] [ text "Conman" ],
          contact (newContact "Bobby Tables" "bobby@example.com"),
          contact (newContact "Molly Apples" "molly@example.com"),
          contact (newContact "Elroy Bacon" "el_bacon@example.com")
        ]


      contact contact =
        div [ ] [
          h2 [ ] [ text contact.name ],
          div [ ]
          [
            label [ ] [ text "Email:" ],
            a [ href ("mailto:" ++ contact.email) ] [ text contact.email ]
          ]
        ]
      ```

  3. Note the parentheses around the call to the newContact function. This can be confusing when you first start using Elm. In Elm the parentheses denote precedence, exactly as the do in Math(s). So it is just saying, "do this part first". That will allow the contact View to be passed the resulting record rather than a function definition and two strings, which would be case if the parentheses were not there.
  4. We can now easily add new data to our model. Let's add a phone number.

      ```elm
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
          contact (newContact "Bobby Tables" "bobby@example.com"    "01 234 5678"),
          contact (newContact "Molly Apples" "molly@example.com"    "01 789 2340"),
          contact (newContact "Elroy Bacon"  "el_bacon@example.com" "01 398 7654")
        ]


      contact contact =
        div [ ] [
          h2 [ ] [ text contact.name ],
          div [ ]
          [
            label [ ] [ text "Email:" ],
            a [ href ("mailto:" ++ contact.email) ] [ text contact.email ]
          ],
          div [ ]
          [
            label [ ] [ text "Phone:" ],
            a [ href ("tel:" ++ contact.phone) ] [ text contact.phone ]
          ]
        ]
      ```

  5. Finally, our list of contacts is now looking very much like a list. So let's make it one by extracting another View

      ```elm
      view =
        div [ class "container" ]
        [
          h1 [ ] [ text "Conman" ],
          contactList
        ]


      contactList =
        ul [ ]
        [ contact (newContact "Bobby Tables" "bobby@example.com" "01 234 5678"),
          contact (newContact "Molly Apples" "molly@example.com" "01 789 2340"),
          contact (newContact "Elroy Bacon" "el_bacon@example.com" "01 398 7654")
        ]


      contact contact =
        li [ ] [
      ```

  6. To wrap up we'll add a little bit of style. Style sheet available in the example code, or you can make your own (and no doubt do a better job)!

      ```elm
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
      ```
