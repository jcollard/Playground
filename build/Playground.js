Elm.Playground = Elm.Playground || {};
Elm.Playground.make = function (_elm) {
   "use strict";
   _elm.Playground = _elm.Playground || {};
   if (_elm.Playground.values)
   return _elm.Playground.values;
   var _op = {},
   _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Playground",
   $Basics = Elm.Basics.make(_elm),
   $Graphics$Collage = Elm.Graphics.Collage.make(_elm),
   $Graphics$Element = Elm.Graphics.Element.make(_elm),
   $Internal = Elm.Internal.make(_elm),
   $Playground$Input = Elm.Playground.Input.make(_elm),
   $Signal = Elm.Signal.make(_elm),
   $Time = Elm.Time.make(_elm),
   $Window = Elm.Window.make(_elm);
   var playWithRate = F2(function (rate,
   playground) {
      return function () {
         var input = A2($Signal._op["~"],
         A2($Signal._op["<~"],
         F2(function (v0,v1) {
            return {ctor: "_Tuple2"
                   ,_0: v0
                   ,_1: v1};
         }),
         $Internal.realworld),
         $Internal.inputs(rate));
         var update = $Internal.updater(playground.update);
         return A2($Signal._op["~"],
         A2($Signal._op["<~"],
         $Basics.uncurry($Graphics$Collage.collage),
         $Window.dimensions),
         A2($Signal._op["<~"],
         playground.render,
         A3($Signal.foldp,
         update,
         playground.initialState,
         input)));
      }();
   });
   var play = playWithRate(60);
   var Playground = F3(function (a,
   b,
   c) {
      return {_: {}
             ,initialState: b
             ,render: a
             ,update: c};
   });
   _elm.Playground.values = {_op: _op
                            ,Playground: Playground
                            ,play: play
                            ,playWithRate: playWithRate};
   return _elm.Playground.values;
};Elm.Internal = Elm.Internal || {};
Elm.Internal.make = function (_elm) {
   "use strict";
   _elm.Internal = _elm.Internal || {};
   if (_elm.Internal.values)
   return _elm.Internal.values;
   var _op = {},
   _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Internal",
   $Basics = Elm.Basics.make(_elm),
   $Char = Elm.Char.make(_elm),
   $Dict = Elm.Dict.make(_elm),
   $Keyboard = Elm.Keyboard.make(_elm),
   $Keyboard$Keys = Elm.Keyboard.Keys.make(_elm),
   $List = Elm.List.make(_elm),
   $Maybe = Elm.Maybe.make(_elm),
   $Mouse = Elm.Mouse.make(_elm),
   $Playground$Input = Elm.Playground.Input.make(_elm),
   $Set = Elm.Set.make(_elm),
   $Signal = Elm.Signal.make(_elm),
   $Time = Elm.Time.make(_elm),
   $Window = Elm.Window.make(_elm);
   var justs = function (chars) {
      return function () {
         var helper = F2(function (xs,
         acc) {
            return function () {
               switch (xs.ctor)
               {case "::": return function () {
                       switch (xs._0.ctor)
                       {case "Just": return A2(helper,
                            xs._1,
                            A2($List._op["::"],
                            xs._0._0,
                            acc));
                          case "Nothing":
                          return A2(helper,xs._1,acc);}
                       _E.Case($moduleName,
                       "between lines 101 and 103");
                    }();
                  case "[]": return acc;}
               _E.Case($moduleName,
               "between lines 99 and 103");
            }();
         });
         return A2(helper,
         chars,
         _L.fromArray([]));
      }();
   };
   var specialKeys = $Dict.fromList(_L.fromArray([{ctor: "_Tuple2"
                                                  ,_0: 17
                                                  ,_1: $Keyboard$Keys.ctrl}
                                                 ,{ctor: "_Tuple2"
                                                  ,_0: 16
                                                  ,_1: $Keyboard$Keys.shift}
                                                 ,{ctor: "_Tuple2"
                                                  ,_0: 32
                                                  ,_1: $Keyboard$Keys.space}
                                                 ,{ctor: "_Tuple2"
                                                  ,_0: 13
                                                  ,_1: $Keyboard$Keys.enter}]));
   var alphas$$ = _L.fromArray([$Keyboard$Keys.a
                               ,$Keyboard$Keys.b
                               ,$Keyboard$Keys.c
                               ,$Keyboard$Keys.d
                               ,$Keyboard$Keys.e
                               ,$Keyboard$Keys.f
                               ,$Keyboard$Keys.g
                               ,$Keyboard$Keys.h
                               ,$Keyboard$Keys.i
                               ,$Keyboard$Keys.j
                               ,$Keyboard$Keys.k
                               ,$Keyboard$Keys.l
                               ,$Keyboard$Keys.m
                               ,$Keyboard$Keys.n
                               ,$Keyboard$Keys.o
                               ,$Keyboard$Keys.p
                               ,$Keyboard$Keys.q
                               ,$Keyboard$Keys.r
                               ,$Keyboard$Keys.s
                               ,$Keyboard$Keys.t
                               ,$Keyboard$Keys.u
                               ,$Keyboard$Keys.v
                               ,$Keyboard$Keys.w
                               ,$Keyboard$Keys.x
                               ,$Keyboard$Keys.y
                               ,$Keyboard$Keys.z]);
   var alphas$ = A2($List.map,
   $Char.toCode,
   _L.fromArray([_U.chr("a")
                ,_U.chr("b")
                ,_U.chr("c")
                ,_U.chr("d")
                ,_U.chr("e")
                ,_U.chr("f")
                ,_U.chr("g")
                ,_U.chr("h")
                ,_U.chr("i")
                ,_U.chr("j")
                ,_U.chr("k")
                ,_U.chr("l")
                ,_U.chr("m")
                ,_U.chr("n")
                ,_U.chr("o")
                ,_U.chr("p")
                ,_U.chr("q")
                ,_U.chr("r")
                ,_U.chr("s")
                ,_U.chr("t")
                ,_U.chr("u")
                ,_U.chr("v")
                ,_U.chr("w")
                ,_U.chr("x")
                ,_U.chr("y")
                ,_U.chr("z")]));
   var alphaKeys = $Dict.fromList(A2($List.zip,
   alphas$,
   alphas$$));
   var arrowKeys = $Dict.fromList(_L.fromArray([{ctor: "_Tuple2"
                                                ,_0: 37
                                                ,_1: $Keyboard$Keys.arrowLeft}
                                               ,{ctor: "_Tuple2"
                                                ,_0: 38
                                                ,_1: $Keyboard$Keys.arrowUp}
                                               ,{ctor: "_Tuple2"
                                                ,_0: 39
                                                ,_1: $Keyboard$Keys.arrowRight}
                                               ,{ctor: "_Tuple2"
                                                ,_0: 40
                                                ,_1: $Keyboard$Keys.arrowDown}]));
   var numbers$$ = _L.fromArray([$Keyboard$Keys.zero
                                ,$Keyboard$Keys.one
                                ,$Keyboard$Keys.two
                                ,$Keyboard$Keys.three
                                ,$Keyboard$Keys.four
                                ,$Keyboard$Keys.five
                                ,$Keyboard$Keys.six
                                ,$Keyboard$Keys.seven
                                ,$Keyboard$Keys.eight
                                ,$Keyboard$Keys.nine]);
   var numbers$ = A2($List.map,
   $Char.toCode,
   _L.fromArray([_U.chr("0")
                ,_U.chr("1")
                ,_U.chr("2")
                ,_U.chr("3")
                ,_U.chr("4")
                ,_U.chr("5")
                ,_U.chr("6")
                ,_U.chr("7")
                ,_U.chr("8")
                ,_U.chr("9")]));
   var numbers = $Dict.fromList(A2($List.zip,
   numbers$,
   numbers$$));
   var keys = A3($List.foldr,
   $Dict.union,
   $Dict.empty,
   _L.fromArray([alphaKeys
                ,specialKeys
                ,arrowKeys
                ,numbers]));
   var toKey = function (code) {
      return A2($Dict.get,
      code,
      keys);
   };
   var toKeys = function ($) {
      return justs($List.map(toKey)($));
   };
   var keysDown = A2($Signal._op["<~"],
   function ($) {
      return $List.map($Playground$Input.Key)(toKeys($));
   },
   $Keyboard.keysDown);
   var lastPressed = function () {
      var match = F2(function (c,
      d) {
         return A2($Set.member,
         c,
         $Set.fromList(d));
      });
      var matchSig = A2($Signal._op["~"],
      A2($Signal._op["<~"],
      match,
      $Keyboard.lastPressed),
      $Signal.merges(_L.fromArray([$Keyboard.keysDown
                                  ,A2($Signal.sampleOn,
                                  A2($Time.delay,
                                  1,
                                  $Keyboard.keysDown),
                                  $Signal.constant(_L.fromArray([])))])));
      return A2($Signal._op["<~"],
      function (c) {
         return $List.map($Playground$Input.Tap)(toKeys(_L.fromArray([c])));
      },
      A3($Signal.keepWhen,
      matchSig,
      0,
      $Keyboard.lastPressed));
   }();
   var toInputs = F3(function (t,
   click,
   keys) {
      return A2($List._op["::"],
      $Playground$Input.Passive(t),
      A2($List._op["::"],click,keys));
   });
   var withRate = function (rate) {
      return function () {
         var rate$ = $Time.fps(rate);
         return A2($Signal._op["~"],
         A2($Signal._op["~"],
         A2($Signal._op["<~"],
         toInputs,
         rate$),
         A2($Signal.sampleOn,
         $Mouse.clicks,
         $Signal.constant($Playground$Input.MouseDown))),
         keysDown);
      }();
   };
   var singleton = function (x) {
      return _L.fromArray([x]);
   };
   var click = A2($Signal._op["<~"],
   singleton,
   A2($Signal.sampleOn,
   $Mouse.clicks,
   $Signal.constant($Playground$Input.Click)));
   var inputs = function (rate) {
      return $Signal.merges(_L.fromArray([click
                                         ,lastPressed
                                         ,withRate(rate)]));
   };
   var updater = F3(function (update,
   _v5,
   state) {
      return function () {
         switch (_v5.ctor)
         {case "_Tuple2":
            return A3($List.foldl,
              update(_v5._0),
              state,
              _v5._1);}
         _E.Case($moduleName,
         "on line 32, column 33 to 59");
      }();
   });
   var toRealWorld = F2(function (_v9,
   _v10) {
      return function () {
         switch (_v10.ctor)
         {case "_Tuple2":
            return function () {
                 switch (_v9.ctor)
                 {case "_Tuple2":
                    return function () {
                         var right = $Basics.toFloat(_v9._0) / 2;
                         var left = 0 - right;
                         var mouseX = $Basics.toFloat(_v10._0) + right;
                         var top = $Basics.toFloat(_v9._1) / 2;
                         var bottom = 0 - top;
                         var mouseY = $Basics.toFloat(_v10._1) + bottom;
                         return {_: {}
                                ,bottom: bottom
                                ,left: left
                                ,mouse: {_: {}
                                        ,x: mouseX
                                        ,y: mouseY}
                                ,right: right
                                ,top: top};
                      }();}
                 _E.Case($moduleName,
                 "between lines 16 and 26");
              }();}
         _E.Case($moduleName,
         "between lines 16 and 26");
      }();
   });
   var realworld = A2($Signal._op["~"],
   A2($Signal._op["<~"],
   toRealWorld,
   $Window.dimensions),
   $Mouse.position);
   _elm.Internal.values = {_op: _op
                          ,toRealWorld: toRealWorld
                          ,realworld: realworld
                          ,updater: updater
                          ,inputs: inputs
                          ,singleton: singleton
                          ,click: click
                          ,toInputs: toInputs
                          ,withRate: withRate
                          ,lastPressed: lastPressed
                          ,keysDown: keysDown
                          ,keys: keys
                          ,numbers: numbers
                          ,numbers$: numbers$
                          ,numbers$$: numbers$$
                          ,arrowKeys: arrowKeys
                          ,alphaKeys: alphaKeys
                          ,alphas$: alphas$
                          ,alphas$$: alphas$$
                          ,specialKeys: specialKeys
                          ,toKeys: toKeys
                          ,toKey: toKey
                          ,justs: justs};
   return _elm.Internal.values;
};Elm.Playground = Elm.Playground || {};
Elm.Playground.Input = Elm.Playground.Input || {};
Elm.Playground.Input.make = function (_elm) {
   "use strict";
   _elm.Playground = _elm.Playground || {};
   _elm.Playground.Input = _elm.Playground.Input || {};
   if (_elm.Playground.Input.values)
   return _elm.Playground.Input.values;
   var _op = {},
   _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Playground.Input",
   $Keyboard$Keys = Elm.Keyboard.Keys.make(_elm),
   $Time = Elm.Time.make(_elm);
   var Passive = function (a) {
      return {ctor: "Passive"
             ,_0: a};
   };
   var MouseDown = {ctor: "MouseDown"};
   var Click = {ctor: "Click"};
   var Key = function (a) {
      return {ctor: "Key",_0: a};
   };
   var Tap = function (a) {
      return {ctor: "Tap",_0: a};
   };
   var RealWorld = F5(function (a,
   b,
   c,
   d,
   e) {
      return {_: {}
             ,bottom: c
             ,left: d
             ,mouse: e
             ,right: b
             ,top: a};
   });
   _elm.Playground.Input.values = {_op: _op
                                  ,RealWorld: RealWorld
                                  ,Tap: Tap
                                  ,Key: Key
                                  ,Click: Click
                                  ,MouseDown: MouseDown
                                  ,Passive: Passive};
   return _elm.Playground.Input.values;
};Elm.Keyboard = Elm.Keyboard || {};
Elm.Keyboard.Keys = Elm.Keyboard.Keys || {};
Elm.Keyboard.Keys.make = function (_elm) {
   "use strict";
   _elm.Keyboard = _elm.Keyboard || {};
   _elm.Keyboard.Keys = _elm.Keyboard.Keys || {};
   if (_elm.Keyboard.Keys.values)
   return _elm.Keyboard.Keys.values;
   var _op = {},
   _N = Elm.Native,
   _U = _N.Utils.make(_elm),
   _L = _N.List.make(_elm),
   _A = _N.Array.make(_elm),
   _E = _N.Error.make(_elm),
   $moduleName = "Keyboard.Keys",
   $Basics = Elm.Basics.make(_elm),
   $Keyboard = Elm.Keyboard.make(_elm),
   $Signal = Elm.Signal.make(_elm);
   var zero = {_: {}
              ,keyCode: 58
              ,name: "0"};
   var nine = {_: {}
              ,keyCode: 57
              ,name: "9"};
   var eight = {_: {}
               ,keyCode: 56
               ,name: "8"};
   var seven = {_: {}
               ,keyCode: 55
               ,name: "7"};
   var six = {_: {}
             ,keyCode: 54
             ,name: "6"};
   var five = {_: {}
              ,keyCode: 53
              ,name: "5"};
   var four = {_: {}
              ,keyCode: 52
              ,name: "4"};
   var three = {_: {}
               ,keyCode: 51
               ,name: "3"};
   var two = {_: {}
             ,keyCode: 50
             ,name: "2"};
   var one = {_: {}
             ,keyCode: 49
             ,name: "1"};
   var f10 = {_: {}
             ,keyCode: 121
             ,name: "F10"};
   var f9 = {_: {}
            ,keyCode: 120
            ,name: "F9"};
   var f8 = {_: {}
            ,keyCode: 119
            ,name: "F8"};
   var f4 = {_: {}
            ,keyCode: 115
            ,name: "F4"};
   var f2 = {_: {}
            ,keyCode: 113
            ,name: "F2"};
   var escape = {_: {}
                ,keyCode: 27
                ,name: "Escape"};
   var pageUp = {_: {}
                ,keyCode: 33
                ,name: "Page up"};
   var pageDown = {_: {}
                  ,keyCode: 34
                  ,name: "Page down"};
   var home = {_: {}
              ,keyCode: 36
              ,name: "Home"};
   var end = {_: {}
             ,keyCode: 35
             ,name: "End"};
   var insert = {_: {}
                ,keyCode: 45
                ,name: "Insert"};
   var $delete = {_: {}
                 ,keyCode: 46
                 ,name: "Delete"};
   var backspace = {_: {}
                   ,keyCode: 8
                   ,name: "Backspace"};
   var arrowDown = {_: {}
                   ,keyCode: 40
                   ,name: "Down arrow"};
   var arrowUp = {_: {}
                 ,keyCode: 38
                 ,name: "Up arrow"};
   var arrowLeft = {_: {}
                   ,keyCode: 39
                   ,name: "Left arrow"};
   var arrowRight = {_: {}
                    ,keyCode: 37
                    ,name: "Right arrow"};
   var enter = {_: {}
               ,keyCode: 13
               ,name: "Enter"};
   var space = {_: {}
               ,keyCode: 32
               ,name: "Space"};
   var commandRight = {_: {}
                      ,keyCode: 93
                      ,name: "Command right"};
   var commandLeft = {_: {}
                     ,keyCode: 91
                     ,name: "Command left"};
   var windows = {_: {}
                 ,keyCode: 91
                 ,name: "Windows"};
   var meta = {_: {}
              ,keyCode: 91
              ,name: "Meta"};
   var $super = {_: {}
                ,keyCode: 91
                ,name: "Super"};
   var tab = {_: {}
             ,keyCode: 9
             ,name: "Tab"};
   var shift = {_: {}
               ,keyCode: 16
               ,name: "Shift"};
   var ctrl = {_: {}
              ,keyCode: 17
              ,name: "Ctrl"};
   var z = {_: {}
           ,keyCode: 90
           ,name: "z"};
   var y = {_: {}
           ,keyCode: 89
           ,name: "y"};
   var x = {_: {}
           ,keyCode: 88
           ,name: "x"};
   var w = {_: {}
           ,keyCode: 87
           ,name: "w"};
   var v = {_: {}
           ,keyCode: 86
           ,name: "v"};
   var u = {_: {}
           ,keyCode: 85
           ,name: "u"};
   var t = {_: {}
           ,keyCode: 84
           ,name: "t"};
   var s = {_: {}
           ,keyCode: 83
           ,name: "s"};
   var r = {_: {}
           ,keyCode: 82
           ,name: "r"};
   var q = {_: {}
           ,keyCode: 81
           ,name: "q"};
   var p = {_: {}
           ,keyCode: 80
           ,name: "p"};
   var o = {_: {}
           ,keyCode: 79
           ,name: "o"};
   var n = {_: {}
           ,keyCode: 78
           ,name: "n"};
   var m = {_: {}
           ,keyCode: 77
           ,name: "m"};
   var l = {_: {}
           ,keyCode: 76
           ,name: "l"};
   var k = {_: {}
           ,keyCode: 75
           ,name: "k"};
   var j = {_: {}
           ,keyCode: 74
           ,name: "j"};
   var i = {_: {}
           ,keyCode: 73
           ,name: "i"};
   var h = {_: {}
           ,keyCode: 72
           ,name: "h"};
   var g = {_: {}
           ,keyCode: 71
           ,name: "g"};
   var f = {_: {}
           ,keyCode: 70
           ,name: "f"};
   var e = {_: {}
           ,keyCode: 69
           ,name: "e"};
   var d = {_: {}
           ,keyCode: 68
           ,name: "d"};
   var c = {_: {}
           ,keyCode: 67
           ,name: "b"};
   var b = {_: {}
           ,keyCode: 66
           ,name: "b"};
   var a = {_: {}
           ,keyCode: 65
           ,name: "a"};
   var isKeyDown = function (k) {
      return $Keyboard.isDown(k.keyCode);
   };
   var directionKeys = F4(function (up,
   down,
   right,
   left) {
      return A4($Keyboard.directions,
      up.keyCode,
      down.keyCode,
      right.keyCode,
      left.keyCode);
   });
   var equal = F2(function (k0,
   k1) {
      return _U.eq(k0.keyCode,
      k1.keyCode);
   });
   var Key = F2(function (a,b) {
      return {_: {}
             ,keyCode: a
             ,name: b};
   });
   _elm.Keyboard.Keys.values = {_op: _op
                               ,Key: Key
                               ,equal: equal
                               ,directionKeys: directionKeys
                               ,isKeyDown: isKeyDown
                               ,a: a
                               ,b: b
                               ,c: c
                               ,d: d
                               ,e: e
                               ,f: f
                               ,g: g
                               ,h: h
                               ,i: i
                               ,j: j
                               ,k: k
                               ,l: l
                               ,m: m
                               ,n: n
                               ,o: o
                               ,p: p
                               ,q: q
                               ,r: r
                               ,s: s
                               ,t: t
                               ,u: u
                               ,v: v
                               ,w: w
                               ,x: x
                               ,y: y
                               ,z: z
                               ,ctrl: ctrl
                               ,shift: shift
                               ,tab: tab
                               ,$super: $super
                               ,meta: meta
                               ,windows: windows
                               ,commandLeft: commandLeft
                               ,commandRight: commandRight
                               ,space: space
                               ,enter: enter
                               ,arrowRight: arrowRight
                               ,arrowLeft: arrowLeft
                               ,arrowUp: arrowUp
                               ,arrowDown: arrowDown
                               ,backspace: backspace
                               ,$delete: $delete
                               ,insert: insert
                               ,end: end
                               ,home: home
                               ,pageDown: pageDown
                               ,pageUp: pageUp
                               ,escape: escape
                               ,f2: f2
                               ,f4: f4
                               ,f8: f8
                               ,f9: f9
                               ,f10: f10
                               ,one: one
                               ,two: two
                               ,three: three
                               ,four: four
                               ,five: five
                               ,six: six
                               ,seven: seven
                               ,eight: eight
                               ,nine: nine
                               ,zero: zero};
   return _elm.Keyboard.Keys.values;
};