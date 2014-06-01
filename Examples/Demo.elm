import Playground(..)
import Playground.Input(..)
import Keyboard.Keys as Keys

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