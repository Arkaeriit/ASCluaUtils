
all : texclean

texclean : main.o gestionFS.o TexClean.luac
	gcc main.o gestionFS.o -llua -lm -ldl -o texclean

TexClean.luac : TexClean.lua
	luac -o TexClean.luac TexClean.lua

main.o : main.c
	gcc -c main.c -Wall -o main.o

gestionFS.o : gestionFS.c gestionFS.h
	gcc -c gestionFS.c -Wall -o gestionFS.o

clean :
	rm -f *.o
	rm -f *.luac
	rm -f texclean

install : 
	mkdir -p /usr/local/share/texclean
	cp -f texclean /usr/local/bin
	cp -f TexClean.luac /usr/local/share/texclean

uninstall :
	rm -Rf /usr/local/share/texclean
	rm -f /usr/local/bin/texclean

