# elm-ui-cookbook

This repo aims to gather knowledge from https://elmlang.slack.com #elm-ui or elsewhere.

PRs welcomed.

## Examples

- [examples](/examples) directory.
- web interface to control mpv https://github.com/rofrol/elm-mpv-webui
- slider https://github.com/rofrol/elm-mpv-webui/blob/master/webui-page/src/Slider.elm
- more examples https://github.com/bburdette/elm-ui-examples

## Centralize Input.text contents

mthiems 2:33 AM
@VPagani I've seen this before, and I think this may be a bug in the current version of elm-ui. It seems the `input` DOM element needs a `text-align: inherit` style, as the `text-align: center` is on a parent `div` instead of on the `input` itself. Here's an Ellie illustrating one option for a workaround that makes it work:
https://ellie-app.com/6GQLrcSt7hWa1

mgriffith:bulb: 3:06 AM
Ah, yeah, the current way to do that is to capture your spacing a font values in a palette file and always use those.  Then you could do things like set the padding based on font size or whatever you’d like.

https://elmlang.slack.com #elm-ui

## Structuring code

blackeuler 4:46 AM
Is there any strategy when it comes to structing the code? I feel like I have a lot of code in the one file all mainly for the view of the page.

mgriffithbulb 4:58 AM
First suggestion is to take all values and put them in one file (colors, spacing/padding values, font sizes and font families). I usually call this file UI After that, if you find a reusable part of a view, I’d put it in it’s own sub module. So, buttons go in UI.Button. Though it’s also fine to have big files.

https://elmlang.slack.com #elm-ui

## Break long text without spaces

```elm
row [ width fill ]
  [ paragraph
    [ Font.color model.style.color
    , Font.size 40
	, Html.Attributes.style "word-break" "break-all" |> htmlAttribute
    ]
    [ text model.status.filename ]
  ]
```

- https://stackoverflow.com/questions/36150458/flex-item-overflows-container-due-to-long-word-even-after-using-word-wrap/36150638#36150638

`'overflow-wrap: break-word'` will not work when `paragraph` inside `row` so this solution https://stackoverflow.com/questions/3058866/how-to-force-a-line-break-in-a-long-word-in-a-div/3059128#3059128 is bad for flexbox.

## Center wrapped flexbox

You can't

https://stackoverflow.com/questions/32802202/how-to-center-a-flex-container-but-left-align-flex-items/32811002#32811002

## Custom events

Examples in source code https://github.com/mdgriffith/elm-ui/blob/1.1.5/src/Element/Events.elm#L177 but are not exported

## Mouse click coordinates

Examples in source code but on exported https://github.com/mdgriffith/elm-ui/blob/1.1.5/src/Element/Events.elm#L115

## colorToRgbaString

```elm
colorToRgbaString color =
    let
        floatTo256 f =
            if f >= 1 then
                255

            else
                floor (f * 256)

        rgba =
            Element.toRgb color

        floatToString f =
            String.pad 2 '0' (String.fromInt (floatTo256 f))
    in
    "rgba("
        ++ floatToString rgba.red
        ++ ", "
        ++ floatToString rgba.green
        ++ ", "
        ++ floatToString rgba.blue
        ++ ", "
        ++ floatToString rgba.alpha
        ++ ")"
```

## colorToRgbaAttr

```elm
colorToRgbaAttr color =
    let
        { red, green, blue, alpha } =
            toRgb color

        rgb =
            [ red, green, blue ] |> List.map ((*) 255 >> String.fromFloat) |> List.intersperse ", " |> List.foldl (++) ""
    in
    Html.Attributes.style "color" ("rgba(" ++ rgb ++ "," ++ String.fromFloat alpha ++ ")")
```

## Multiple focus bug

wrap each button in an `Element.el`

https://ellie-app.com/5NtSNBJ4bzFa1

https://github.com/mdgriffith/elm-ui/issues/47#issuecomment-501270001

## em values

Sophie   [Yesterday at 10:24 PM]
Is there a way to specify `em` values in `elm-ui`?

jhbrown   [12 hours ago]
There is not.  Just px and percents.

https://elmlang.slack.com #elm-ui

## External css

jesse  7 minutes ago
We primarily use elm-ui and also have external Sass styling too and it’s fine
jesse  6 minutes ago
You may need to use https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/Element#noStaticStyleSheet

https://elmlang.slack.com #news-and-links

## mouseOver and Font.underline

Use `Border` instead:

```elm
            [ Border.color <| rgba255 255 255 255 255
            , Border.widthEach
                { bottom = 1
                , left = 0
                , top = 0
                , right = 0
                }
            , mouseOver [ Border.color <| rgb255 255 0 0 ]
            ]
```

- https://ellie-app.com/7f8nvkjCrD6a1
- https://github.com/mdgriffith/elm-ui/issues/158
