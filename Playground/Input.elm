module Playground.Input where

{-|
  This module explains each type of Input that can be used in a Playground's
  update function.

  @docs Input, Key, Direction

 -}

type RealWorld = { topLeft : (Float, Float),
                   bottomRight : (Float, Float),
                   mousePosition : (Float, Float) }


{-|
  Inputs are passed to a Playground's update function. If multiple inputs are
  generated, the update function is called multiple times accumulating all of
  the changes. Your update function will always be passed a Passive input and
  it is guaranteed that the Passive input will occur before all other inputs.

  * Tap k - Fires once when `k` is pressed
  * Key k - Fires every time the update function is called while `k` is pressed
  * Click - Fires once when the mouse is clicked
  * MouseDown - Fires every time the update function is called while the mouse is down
  * Passive t - This input is always passed to the update function and expresses
    how many milliseconds have passed since the last update was accumulated.


 -}
data Input = Tap Key
           | Key Key
           | Click
           | MouseDown
           | Passive Time

{-|
  A Key on the Keyboard.
 -}
data Key = Ctrl | Shift | Space | Enter
         | A | B | C | D | E | F | G | H | I | J | K | L | M 
         | N | O | P | Q | R | S | T | U | V | W | X | Y | Z
         | Number Int
         | Arrow Direction 

{-|
  Used to determine which Arrow key is pressed.
 -}
data Direction = Up | Down | Left | Right
