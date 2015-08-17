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


## 4. Adding a contact

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

