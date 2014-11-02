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



* Ball: Shows how to create a simple interactive "game" where you can move a ball with the arrow keys and change the color using '1', '2', and '3'.
  - [Demo](http://jcollard.github.io/elm/Playground/Demo.html)
  - [Source](https://github.com/jcollard/Playground/blob/master/Examples/Demo.elm)
* Mario: Shows a more "complex game" where you can move Mario left and right with the arrow keys and jump by pressing up.
  - [Demo](http://jcollard.github.io/elm/Playground/Mario.html)
  - [Source](https://github.com/jcollard/Playground/blob/master/Examples/Mario.elm)
