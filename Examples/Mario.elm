import Playground(..)
import Playground.Input(..)
-- Define what you want the state of your program to be
type State = { x : Float, y : Float, vx : Float, vy : Float, dir : String}

initialState : State
initialState = { x=0, y=0, vx=0, vy=0, dir="right" }

-- Define how the state of your program should be rendered
render : RealWorld -> State -> [Form]
render realworld mario =
  let (w,h) = (realworld.right - realworld.left,
               realworld.top - realworld.bottom)
      verb = if | mario.y  >  0 -> "jump"
                | mario.vx /= 0 -> "walk"
                | otherwise     -> "stand"
      src  = "http://elm-lang.org/imgs/mario/" ++ verb ++ "/" ++ mario.dir ++ ".gif"
  in [ rect w h  |> filled (rgb 174 238 238)
      , rect w 50 |> filled (rgb 74 163 41)
                  |> move (0, 24 - h/2)
      , toForm (image 35 35 src) |> move (mario.x, mario.y + 62 - h/2)
      ]

gravity : Time -> State -> State
gravity t mario = if mario.y > 0 then { mario | vy <- mario.vy - t/4 } else mario

physics : Time -> State -> State
physics t mario = { mario | x <- mario.x + t*mario.vx, 
                          y <- max 0 (mario.y + t*mario.vy),
                          vx <- 0}
jump : State -> State
jump mario = if mario.y == 0 then { mario | vy <- 5 } else mario

-- Define how your program is updated
update : RealWorld -> Input -> State -> State
update realworld input mario = 
    case input of
      Key (Arrow Left) -> {mario | vx <- mario.vx - 2, dir <- "left"}
      Key (Arrow Right) -> {mario | vx <- mario.vx + 2, dir <- "right"}
      Tap (Arrow Up) -> jump mario
      Passive t -> gravity (t/20) (physics (t/20) mario)
      otherwise -> mario 

main = play {render = render, update = update, initialState = initialState}