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
