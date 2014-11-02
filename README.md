Playground
==========

Playground attempts to add a layer of abstraction between the programmer and
Signals.

Examples
========

## Increment
A number appears centered on the screen and increments showing how many milliseconds have passed. If the user presses the space bar, the counter resets.

```haskell
-- Increases an Int ~60 times per second. When the space bar is pressed, the Int
-- resets
update realworld input state = 
  case input of
    Tap k -> if | Keys.equal k Keys.space -> 0
                | otherwise -> state
    otherwise -> state + 1

render state = [asText state |> toForm]

main = play { render = render, update = update, initialState = 0 }
```

[See It Running](http://jcollard.github.io/elm/Playground/Increment.html)


## Ball
A circle is drawn to the screen. Use the arrow keys to move it around the screen. Press `1`, `2`, or `3`, to change the circles color.

```haskell
-- Define what you want the state of your program to be
type State = {x : Float, y : Float, c : Color}
initialState : State
initialState = {x = 0, y = 0, c = blue}

-- Define how the state of your program should be rendered
render : State -> [Form]
render state = 
    let shape = circle 50 |> filled state.c |> move (state.x, state.y) 
    in [shape]

-- Define how your program is updated
update : RealWorld -> Input -> State -> State
update rw input state = 
    case input of
      Tap k ->
          if | Keys.equal k Keys.one -> {state | c <- blue}
             | Keys.equal k Keys.two -> {state | c <- red}
             | Keys.equal k Keys.three -> {state | c <- green}
             | otherwise -> state
      Key k ->
          if | Keys.equal k Keys.arrowLeft -> {state | x <- state.x - 5}
             | Keys.equal k Keys.arrowRight -> {state | x <- state.x + 5}
             | Keys.equal k Keys.arrowDown ->  {state | y <- state.y - 5}
             | Keys.equal k Keys.arrowUp -> {state | y <- state.y + 5}
             | otherwise -> state
      otherwise -> state

playground : Playground State
playground = {render = render, update = update, initialState = initialState}

main : Signal Element
main = play playground
```
[See It Running!](http://jcollard.github.io/elm/Playground/Demo.html)


* Mario: Shows a more "complex game" where you can move Mario left and right with the arrow keys and jump by pressing up.
  - [Demo](http://jcollard.github.io/elm/Playground/Mario.html)
  - [Source](https://github.com/jcollard/Playground/blob/master/Examples/Mario.elm)
