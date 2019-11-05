# elm-ui-cookbook

## Centralize Input.text contents

mthiems 2:33 AM
@VPagani I've seen this before, and I think this may be a bug in the current version of elm-ui. It seems the `input` DOM element needs a `text-align: inherit` style, as the `text-align: center` is on a parent `div` instead of on the `input` itself. Here's an Ellie illustrating one option for a workaround that makes it work:
https://ellie-app.com/6GQLrcSt7hWa1

mgriffith:bulb: 3:06 AM
Ah, yeah, the current way to do that is to capture your spacing a font values in a palette file and always use those.  Then you could do things like set the padding based on font size or whatever you’d like.

https://elmlang.slack.com #elm-ui
