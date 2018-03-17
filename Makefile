
ALL:
	ghc -dynamic parse.hs
	rm -f parse.hi parse.o

clean:
	rm -f parse parse.exe
