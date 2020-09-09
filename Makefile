FLAGS = -Wall -Werror
LUA = -llua -lm -ldl
GFS = -lgestionFS

all : texclean makeclean

texclean : TexClean.o gFS_plus.o TexClean.luac
	gcc TexClean.o gFS_plus.o $(GFS) $(LUA) -o texclean

TexClean.luac : TexClean.lua
	luac -o TexClean.luac TexClean.lua

TexClean.o : TexClean.c
	gcc -c TexClean.c $(FLAGS) -o TexClean.o

makeclean : makeClean.o gFS_plus.o makeClean.luac
	gcc makeClean.o gFS_plus.o $(LUA) $(GFS) -o makeclean

makeClean.luac : makeClean.lua
	luac -o makeClean.luac makeClean.lua

makeClean.o : makeClean.c
	gcc -c makeClean.c $(FLAGS) -o makeClean.o

gFS_plus.o : gFS_plus.c gFS_plus.h
	gcc -c gFS_plus.c $(FLAGS) -o gFS_plus.o

clean :
	rm -f *.o
	rm -f *.luac
	rm -f texclean
	rm -f makeclean

install : installtexclean installmakeclean 

installtexclean : 
	mkdir -p /usr/local/share/ASCluaUtils
	cp -f texclean /usr/local/bin
	cp -f TexClean.luac /usr/local/share/ASCluaUtils

installmakeclean : 
	mkdir -p /usr/local/share/ASCluaUtils
	cp -f makeclean /usr/local/bin
	cp -f makeClean.luac /usr/local/share/ASCluaUtils

uninstall :
	rm -Rf /usr/local/share/ASCluaUtils
	rm -f /usr/local/bin/texclean
	rm -f /usr/local/bin/makeclean

