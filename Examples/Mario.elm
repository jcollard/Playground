import Playground(..)
import Playground.Input(..)
-- Define what you want the state of your program to be
type State = { w : Float, h : Float, x : Float, y : Float, vx : Float, vy : Float, dir : String}

initialState : State
initialState = { w = 0, h = 0, x=0, y=0, vx=0, vy=0, dir="right" }

-- Define how the state of your program should be rendered
render : State -> [Form]
render mario =
  let verb = if | mario.y  >  0 -> "jump"
                | mario.vx /= 0 -> "walk"
                | otherwise     -> "stand"
      src  = "http://elm-lang.org/imgs/mario/" ++ verb ++ "/" ++ mario.dir ++ ".gif"
  in [ rect mario.w mario.h  |> filled (rgb 174 238 238)
      , rect mario.w 50 |> filled (rgb 74 163 41)
                  |> move (0, 24 - mario.h/2)
      , toForm (image 35 35 src) |> move (mario.x, mario.y + 62 - mario.h/2)
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
    let (t,l) = realworld.topLeft
        (b,r) = realworld.bottomRight
        h = t - b
        w = r - l
    in
    case input of
      Key (Arrow Left) -> {mario | vx <- mario.vx - 2, dir <- "left"}
      Key (Arrow Right) -> {mario | vx <- mario.vx + 2, dir <- "right"}
      Key (Arrow Up) -> jump mario
      Passive t -> gravity (t/20) (physics (t/20) {mario | w <- w, h <- h})
      otherwise -> mario 

main = play {render = render, update = update, initialState = initialState}