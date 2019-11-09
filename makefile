
all : texclean makeclean grepDir

texclean : TexClean.o gestionFS.o TexClean.luac
	gcc TexClean.o gestionFS.o -llua -lm -ldl -o texclean

TexClean.luac : TexClean.lua
	luac -o TexClean.luac TexClean.lua

TexClean.o : TexClean.c
	gcc -c TexClean.c -Wall -o TexClean.o

makeclean : makeClean.o gestionFS.o makeClean.luac
	gcc makeClean.o gestionFS.o -llua -lm -ldl -o makeclean

makeClean.luac : makeClean.lua
	luac -o makeClean.luac makeClean.lua

makeClean.o : makeClean.c
	gcc -c makeClean.c -Wall -o makeClean.o

grepDir : grepDir.o gestionFS.o grepDir.luac
	gcc grepDir.o gestionFS.o -llua -lm -ldl -o grepDir

grepDir.luac : grepDir.lua
	luac -o grepDir.luac grepDir.lua

grepDir.o : grepDir.c
	gcc -c grepDir.c -Wall -o grepDir.o

gestionFS.o : gestionFS.c gestionFS.h
	gcc -c gestionFS.c -Wall -o gestionFS.o

clean :
	rm -f *.o
	rm -f *.luac
	rm -f texclean
	rm -f makeclean
	rm -f grepDir

install : installtexclean installmakeclean installgrepdir

installtexclean : 
	mkdir -p /usr/local/share/ASCluaUtils
	cp -f texclean /usr/local/bin
	cp -f TexClean.luac /usr/local/share/ASCluaUtils

installmakeclean : 
	mkdir -p /usr/local/share/ASCluaUtils
	cp -f makeclean /usr/local/bin
	cp -f makeClean.luac /usr/local/share/ASCluaUtils

installgrepdir : 
	mkdir -p /usr/local/share/ASCluaUtils
	cp -f grepDir /usr/local/bin
	cp -f grepDir.luac /usr/local/share/ASCluaUtils

uninstall :
	rm -Rf /usr/local/share/ASCluaUtils
	rm -f /usr/local/bin/texclean
	rm -f /usr/local/bin/makeclean
	rm -f /usr/local/bin/grepDir

