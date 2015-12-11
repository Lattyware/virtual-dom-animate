# Virtual DOM Animation for Elm

This small package adds attributes that change as soon as the element they are in is added to the page, to make using CSS animation nicer and more reliable.

For more detail on how this is achieved, see [the virtual-dom CSS animation doc][css-animations]

Note that this package uses a native module that looks behind the cover of [the elm virtual-dom module][virtual-dom].
This means it is tightly coupled to that module, and changes to it could affect this one, even if the APIs don't change.
As such, you will notice this module is tied to a specific virtual-dom version. If you need a newer version, you can try
changing this, but it may be broken.

This is really more of a proof-of-concept, hopefully this functionality will be exposed through [elm-html][elm-html]
properly at some point.

To see this in use, check [Massive Decks][massivedecks], where it is used to animate played cards.

[css-animations]: https://github.com/Matt-Esch/virtual-dom/blob/master/docs/css-animations.md
[virtual-dom]: https://github.com/evancz/virtual-dom
[elm-html]: https://github.com/evancz/elm-html
[massivedecks]: https://github.com/Lattyware/massivedecks

## Rebuilding from NPM
The build versions of virtual-dom and next-tick are committed inside `src/Native/VirtualDom/Animate.js`. To rebuild
this file with newer versions:

1. Change the `virtual-dom` or `next-tick` version number in `package.json`.
2. Run `npm install`
3. Run `./rebuild.sh`

And you should see changes in `src/Native/VirtualDom/Animate.js`.
