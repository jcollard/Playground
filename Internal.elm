module Internal where
import Playground.Input(..)
import Dict(Dict)
import Dict
import Char
import Keyboard
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
    in { topLeft = (top, left),
         bottomRight = (bottom, right),
         mousePosition = (mouseX, mouseY) }

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

keys : Dict Char.KeyCode Key
keys = foldr Dict.union Dict.empty [alphaKeys, specialKeys, arrowKeys, numbers]

numbers : Dict Char.KeyCode Key
numbers = Dict.fromList <| zip numbers' numbers''

numbers' : [Char.KeyCode]
numbers' = map Char.toCode ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']

numbers'' : [Key]
numbers'' = map Number [0..9]

arrowKeys : Dict Char.KeyCode Key
arrowKeys = Dict.fromList [(37, Arrow Left), (38, Arrow Up), (39, Arrow Right), (40, Arrow Down)]

alphaKeys : Dict Char.KeyCode Key
alphaKeys = Dict.fromList <| zip alphas' alphas''

alphas' : [Char.KeyCode]
alphas' = map Char.toCode ['a','b','c','d','e','f','g','h','i','j','k','l','m',
                           'n','o','p','q','r','s','t','u','v','w','x','y','z']

alphas'' : [Key]
alphas'' = [A, B, C, D, E, F, G, H, I, J, K, L, M,
            N, O, P, Q, R, S, T, U, V, W, X, Y, Z]

specialKeys : Dict Char.KeyCode Key
specialKeys = Dict.fromList [(17, Ctrl), (16, Shift), (32, Space), (13, Enter)]

toKeys : [Char.KeyCode] -> [Key]
toKeys = justs . map toKey

toKey : Char.KeyCode -> Maybe Key
toKey code = Dict.get code keys

