module Playground.Input where

{-|
  This module explains each type of Input that can be used in a Playground's
  update function.

  @docs Input, Direction, Key

 -}


{-|
  Inputs are passed to a Playground's update function. If multiple inputs are
  generated, the update function is called multiple times accumulating all of
  the changes. Your update function will always be passed a Passive input and
  it is guaranteed that the Passive input will occur before all other inputs.

  * MousePos x y - This input is passed in whenever the mouse is moved on the 
    screen. The x and y positions are relative to the top left corner of the
    screen where the top left is x = 0, y = 0.

  * Click x y - Similar to MousePos except it is fired when the left mouse
    button is clicked.

  * Passive t - This input is always passed to the update function and expresses
    how many milliseconds have passed since the last update was accumulated.

  * Key k - This input is passed in once for each key that is currently down.

 -}
data Input = Key Key
           | MousePos Int Int
           | Click Int Int
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
