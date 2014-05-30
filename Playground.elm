module Playground where

{-|
The Playground Library is a layer that abstracts away the need to write explicit
Signals. To get started, one provides a `Playground` record and then passes that
record to `play`. 

```
import Playground(..)
import Playground.Input(..)
-- Increases an Int ~60 times per second. When the space bar is pressed, the Int
-- resets
update input state = 
  case input of
    Key Space -> 0
    otherwise -> state + 1

render (w, h) state = asText state

main = play { render = render, update = update, initialState = 0 }
```

# Playground Record

@docs Playground

# Playing a Playground

@docs play, playWithRate

-}

import Internal(..)
import Playground.Input(..)
import Window

{-|
A Playground record defines the execution path for a program. To create one, you
must specify three fields: initialState, render, and update.

* The `initialState` field describes the state of the Playground after it has
  been loaded.
* The `render` field is a function which describes how your state should be
  transformed into an element that can be displays. It takes in a pair
  describing the width and height of the screen and a state to render.
* The `update` field is a function that takes in an Input, a State to update,
  and returns the updated State. All possible Inputs are defined in
  Playground.Input
-}
type Playground state = { render : ((Int, Int) -> state -> Element),
                          initialState : state,
                          update : Input -> state -> state }
                               

{-|
Plays a Playground record at 60 frames per second.
-}
play : Playground state -> Signal Element
play = playWithRate 60

{-|
Plays a Playground at the specified number of frames per second.
-}
playWithRate : Time -> Playground state -> Signal Element
playWithRate rate playground =
    let update = updater playground.update
        input = inputs rate
    in playground.render <~ Window.dimensions ~ foldp update playground.initialState input


