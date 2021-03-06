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


## 6. Making an initial model

  1. Rather than generate the initial state of the application in the View, we should really be doing that in the Model instead.
  2. Let's start by creating an `initialModel` function (this name is a convention) and having it return a record that contains our list of contacts

    ```elm
    initialModel =
      { contacts =
          [ newContact "Bobby Tables" "bobby@example.com"    "01 234 5678",
            newContact "Molly Apples" "molly@example.com"    "01 789 2340",
            newContact "Elroy Bacon"  "el_bacon@example.com" "01 398 7654"
          ]
      }
    ```

  3. Now we pass that initialModel in to our View when we call it

    ```elm
    main =
      view initialModel
    ```

  4. Then pass the initialModel's contacts list through the the contactList View

    ```elm
    contactList contacts =
      ul [ class "contact-list" ] (List.map contactListItem contacts)

    contactListItem contact =
    ```

  5. Which then generates a contact View (renamed to contactListItem to prevent confusion) for each of the contacts in the contacts list. Note the we use parentheses again to denote the `List.map` gets called first. This will return a List (hence why we don't need to surround the result in square brackets) of contactListItem Views with the current contact information filled in.
  6. What we have now moved towards is a more declarative way of describing the application. The View code just states how the current model will be rendered to the browser. The initialModel describes the state in which the application will start.



## 7. Building a Phoenix data API to serve contact data

  1. To make things a little more interesting, let's bring the initial contact list in from an external service. In this instance from a simple Phoenix data API that we're about to build.
  2. Move to the folder where you want to create your Phoenix app and then `mix Phoenix.new conman_data`
  3. Now `cd conman_data` and create the necessary database structure by typing `mix ecto.create`.
  4. You can test that everything is going to plan by running `mix test` to run the test suite. You should have 4 passing tests.
  5. Creating a data API for our contacts is very easy thanks to Phoenix's generators. Let's do this now as follows:

    ```elixir
    mix phoenix.gen.json Contact contacts name:string email:string phone:string
    mix ecto.migrate
    ```

  6. And then open up our favourite editor and change the last block in our `web/router.ex` file to read

    ```elixir
    scope "/api", ConmanData do
      pipe_through :api

      resources "/contacts", ContactController
    end
    ```

  7. We can check that we haven't broken anything by running `mix test` again. This time we should have 14 passing tests.
  8. Now we can check the fruits of our labour in the browser by running `iex -S mix Phoenix.server` and then visiting [http://localhost:4000/api/contacts](http://localhost:4000/api/contacts). You should see a JSON response with an empty data array.
  9. The easiest way to get the existing contact data into our API is to use the repl. Go back to the terminal window where your server is running and hit the enter key to get a repl prompt. Add the contact data as follows:

    ```elixir
    bobby = %ConmanData.Contact{name: "Bobby Tables", email: "bobby@example.com", phone: "01 234 5678"}
    ConmanData.Repo.insert(bobby)
    molly = %ConmanData.Contact{name: "Molly Apples", email: "molly@example.com", phone: "01 789 2340"}
    ConmanData.Repo.insert(molly)
    elroy = %ConmanData.Contact{name: "Elroy Bacon", email: "el_bacon@example.com", phone: "01 398 7654"}
    ConmanData.Repo.insert(elroy)
    ```

  10. Now if we go back to our browser and refresh we should see that we have 3 contacts now ... only all we can see is their IDs! We can fix this by opening up `web/views/contact_view.ex` in our editor and changing `render ("contact.json" ...` function definition to the following:

    ```elixir
    def render("contact.json", %{contact: contact}) do
      %{
        id: contact.id,
        name: contact.name,
        email: contact.email,
        phone: contact.phone
      }
    end
    ```

  11. Refresh the browser again and you should see the contact list as JSON \o/


## 8. Changing the entire app to use the new StartApp with Effects workflow

1. Rather than try to explain this here, just check the commit that this line is part of ;)
2. I'll delve into what is happening here when I come to wrote the post itself
3. Also looks like I might have to reverse engineer the rest of the blog post to suit this otherwise it'll be confusing as all hell.


## 9. Setting up CORS in Phoenix

1. If we try to do the above, we'll get a CORS error. To add CORS support to our Phoenix app, we can do as follows.
2. In `mix.exs`

  ```elixir
  defp deps do
    [...,
     {:cors_plug, "~> 0.1.3"},
     ...]
  end
  ```

2. In `router.ex`

  ```elixir
  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end
  ```
