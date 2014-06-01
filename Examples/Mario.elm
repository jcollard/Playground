import Playground(..)
import Playground.Input(..)
import Keyboard.Keys as Keys

-- Define what you want the state of your program to be
type State = { mario : Mario, background : Background}
type Background = { w : Float, h : Float }
type Mario = { x : Float, y : Float, vx : Float, vy : Float, dir : String}

initialState : State
initialState = { mario = { x=0, y=0, vx=0, vy=0, dir="right" }, 
                 background = {w = 0, h = 0}}

-- Define how the state of your program should be rendered
render : State -> [Form]
render {mario, background} =
  let (w,h) = (background.w, background.h)
      verb = if | mario.y  >  0 -> "jump"
                | mario.vx /= 0 -> "walk"
                | otherwise     -> "stand"
      src  = "http://elm-lang.org/imgs/mario/" ++ verb ++ "/" ++ mario.dir ++ ".gif"
  in [ rect w h  |> filled (rgb 174 238 238)
      , rect w 50 |> filled (rgb 74 163 41)
                  |> move (0, 24 - h/2)
      , toForm (image 35 35 src) |> move (mario.x, mario.y + 62 - h/2)
      ]

gravity : Time -> Mario -> Mario
gravity t mario = if mario.y > 0 then { mario | vy <- mario.vy - t/4 } else mario

physics : Time -> Mario -> Mario
physics t mario = { mario | x <- mario.x + t*mario.vx, 
                          y <- max 0 (mario.y + t*mario.vy),
                          vx <- 0}
jump : Mario -> Mario
jump mario = if mario.y == 0 then { mario | vy <- 5 } else mario

-- Define how your program is updated
update : RealWorld -> Input -> State -> State
update realworld input {mario, background} = 
       let mario' =
           case input of
             Key k ->
                 if | Keys.equal k Keys.arrowLeft -> {mario | vx <- mario.vx - 2, dir <- "left"}
                    | Keys.equal k Keys.arrowRight -> {mario | vx <- mario.vx + 2, dir <- "right"}
                    | otherwise -> mario
             Tap k ->
                 if | Keys.equal k Keys.arrowUp -> jump mario
                    | otherwise -> mario
             Passive t -> gravity (t/20) (physics (t/20) mario)
             otherwise -> mario
       in {mario = mario', 
           background = { w = realworld.right - realworld.left,
                          h = realworld.top - realworld.bottom}}

main = play {render = render, update = update, initialState = initialState}