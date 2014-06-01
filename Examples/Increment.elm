import Playground(..)
import Playground.Input(..)
-- Increases an Int ~60 times per second. When the space bar is pressed, the Int
-- resets
update realworld input state = 
  case input of
    Key Space -> 0
    otherwise -> state + 1

render state = [asText state |> toForm]

main = play { render = render, update = update, initialState = 0 }
