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
