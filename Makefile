CC = /usr/lib/elm/0.12.3/elm
build = build/
runtime = elm/elm-runtime.js
examples=Examples/
flags = --make --set-runtime=$(runtime) --build-dir=$(build) --src-dir=$(examples)

all: compile examples

compile: build/elm/ build/Playground.js

examples: build/elm/ build/Demo.html build/Mario.html build/Increment.html

build/Increment.html:Examples/Increment.elm build/Playground.js
	$(CC) $(flags) Increment.elm

build/Demo.html:Examples/Demo.elm build/Playground.js
	$(CC) $(flags) Demo.elm

build/elm:elm/
	cp elm/ build/ -r

build/Playground.js:Playground.elm
	$(CC) $(flags) -o Playground.elm

build/Mario.html:Examples/Mario.elm build/Playground.js
	$(CC) $(flags) Mario.elm

clean: build	
	find . -name "*~" -type f -delete
	rm build -rf
	rm cache -rf
