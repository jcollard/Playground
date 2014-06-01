module Playground where

{-|
The Playground Library is a layer that abstracts away the need to write explicit
Signals. To get started, one provides a `Playground` record and then passes that
record to `play`. 

## Quick Demo

The following is a quick Demo of a program that increments a number
repeatedly. When the space bar is pressed, the number is reset to 0.

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

## Playground Record

@docs Playground

## Playing a Playground

@docs play, playWithRate

## Examples
* Increment
  - [Demo](http://people.cs.umass.edu/~jcollard/examples/Playground/build/Increment.html)
  - [Source](https://github.com/jcollard/Playground/blob/master/Examples/Increment.elm)
* Ball
  - [Demo](http://people.cs.umass.edu/~jcollard/examples/Playground/build/Demo.html)
  - [Source](https://github.com/jcollard/Playground/blob/master/Examples/Demo.elm)
* Mario
  - [Demo](http://people.cs.umass.edu/~jcollard/examples/Playground/build/Mario.html)
  - [Source](https://github.com/jcollard/Playground/blob/master/Examples/Mario.elm)


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
  transformed into a set of Forms that can be displayed.

* The `update` field is a function that takes in the RealWorld, an Input event,
  a State to update, and returns the updated State. All possible Inputs are 
  defined in Playground.Input. The RealWorld is defined in Playground.Input.
-}
type Playground state = { render : state -> [Form],
                          initialState : state,
                          update : RealWorld -> Input -> state -> state }
                               



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
        input = (,) <~ realworld ~ inputs rate
    in uncurry collage <~ Window.dimensions ~ (playground.render <~ foldp update playground.initialState input)
