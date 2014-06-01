import Playground(..)
import Playground.Input(..)
import Keyboard.Keys as Keys
-- Increases an Int ~60 times per second. When the space bar is pressed, the Int
-- resets
update realworld input state = 
  case input of
    Tap k -> if | Keys.equal k Keys.space -> 0
                | otherwise -> state
    otherwise -> state + 1

render state = [asText state |> toForm]

main = play { render = render, update = update, initialState = 0 }
