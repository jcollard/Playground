module Internal where
import Playground.Input(..)
import Dict(Dict)
import Dict
import Char
import Keyboard
import Keyboard.Keys as K
import Mouse
import Window
import Time
import Set

toRealWorld : (Int, Int) -> (Int, Int) -> RealWorld
toRealWorld (width, height) (x, y) = 
    let top = (toFloat height)/2
        bottom = -top
        right = (toFloat width)/2
        left = -right
        mouseX = (toFloat x) + right
        mouseY = (toFloat y) + bottom
    in { top = top,
         right = right,
         bottom = bottom,
         left = left,
         mouse = {x = mouseX, y = mouseY}}

realworld : Signal RealWorld
realworld = toRealWorld <~ Window.dimensions ~ Mouse.position

updater : (RealWorld -> Input -> state -> state) -> (RealWorld, [Input]) -> state -> state
updater update (rw, is) state = foldl (update rw) state is

inputs : Time -> Signal [Input]
inputs rate = merges [click, lastPressed, withRate rate]

singleton : a -> [a]
singleton x = [x]

-- Define Mouse Inputs
click : Signal [Input]
click = singleton <~ sampleOn Mouse.clicks (constant Click)

toInputs : Time -> Input -> [Input] -> [Input]
toInputs t click keys = (Passive t)::click::keys

withRate : Time -> Signal [Input]
withRate rate = 
    let rate' = fps rate in
    toInputs <~ rate' ~ (sampleOn Mouse.clicks (constant MouseDown)) ~ keysDown

-- Define Keyboard Inputs
lastPressed : Signal [Input]
lastPressed = 
    let match = (\c d -> Set.member c (Set.fromList d))        
        matchSig = match <~ Keyboard.lastPressed ~ merges [Keyboard.keysDown, sampleOn (Time.delay 1 Keyboard.keysDown) (constant [])]
    in (\c -> map Tap . toKeys <| [c]) <~ (keepWhen matchSig 0 Keyboard.lastPressed)

keysDown : Signal [Input]
keysDown = map Key . toKeys <~ Keyboard.keysDown

keys : Dict Char.KeyCode K.Key
keys = foldr Dict.union Dict.empty [alphaKeys, specialKeys, arrowKeys, numbers]

numbers : Dict Char.KeyCode K.Key
numbers = Dict.fromList <| zip numbers' numbers''

numbers' : [Char.KeyCode]
numbers' = map Char.toCode ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

numbers'' : [K.Key]
numbers'' = [K.zero, K.one, K.two, K.three, K.four, K.five, K.six, K.seven, K.eight, K.nine]

arrowKeys : Dict Char.KeyCode K.Key
arrowKeys = Dict.fromList [(37, K.arrowLeft), (38, K.arrowUp), (39, K.arrowRight), (40, K.arrowDown)]

alphaKeys : Dict Char.KeyCode K.Key
alphaKeys = Dict.fromList <| zip alphas' alphas''

alphas' : [Char.KeyCode]
alphas' = map Char.toCode ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                           'n','o','p','q','r','s','t','u','v','w','x','y','z']

alphas'' : [K.Key]
alphas'' = [K.a, K.b, K.c, K.d, K.e, K.f, K.g, K.h, K.i, K.j, K.k, K.l, K.m,
            K.n, K.o, K.p, K.q, K.r, K.s, K.t, K.u, K.v, K.w, K.x, K.y, K.z]

specialKeys : Dict Char.KeyCode K.Key
specialKeys = Dict.fromList [(17, K.ctrl), (16, K.shift), (32, K.space), (13, K.enter)]

toKeys : [Char.KeyCode] -> [K.Key]
toKeys = justs . map toKey

toKey : Char.KeyCode -> Maybe K.Key
toKey code = Dict.get code keys

