module Internal where
import Playground.Input(..)
import Dict(Dict)
import Dict
import Char
import Keyboard
import Mouse

updater : (Input -> state -> state) -> [Input] -> state -> state
updater update is state = foldl update state is

inputs : Time -> Signal [Input]
inputs rate = merges [keysDown rate, singleton <~ position, singleton <~ click]

singleton : a -> [a]
singleton x = [x]

-- Define Mouse Inputs
position : Signal Input
position = uncurry MousePos <~ Mouse.position

click : Signal Input
click = uncurry Click <~ sampleOn Mouse.clicks Mouse.position

-- Define Keyboard Inputs
keysDown : Time -> Signal [Input]
keysDown rate = 
    let rate' = fps rate in
    (\t ks -> (Passive t)::ks) <~ rate' ~ sampleOn rate' (map Key . toKeys <~ Keyboard.keysDown)

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

