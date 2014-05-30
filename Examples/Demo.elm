import Playground(..)
import Playground.Input(..)
-- Define what you want the state of your program to be
type State = {x : Float, y : Float, c : Color}
initialState : State
initialState = {x = 0, y = 0, c = blue}

-- Define how the state of your program should be rendered
render : (Int, Int) -> State -> Element
render (w, h) state = 
    let shape = circle 50 |> filled state.c |> move (state.x, state.y) 
    in collage w h [shape]

-- Define how your program is updated
update : Input -> State -> State
update input state = 
    case input of
      Key (Number 1) -> {state | c <- blue}
      Key (Number 2) -> {state | c <- red}
      Key (Number 3) -> {state | c <- green}
      Key (Arrow Left) -> {state | x <- state.x - 5}
      Key (Arrow Right)  -> {state | x <- state.x + 5}
      Key (Arrow Down)  -> {state | y <- state.y - 5}
      Key (Arrow Up)    -> {state | y <- state.y + 5}
      otherwise -> state

playground : Playground State
playground = {render = render, update = update, initialState = initialState}

main : Signal Element
main = play playground