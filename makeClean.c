#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <string.h>
#include "gFS_plus.h"

#define devel 0

void manuel(void);

int main(int argc,char** argv){
    //L est la machine lua principale
    lua_State* L;
    L = luaL_newstate();
    luaL_openlibs(L);

    //On charge les fichiers
#if devel == 1
    fprintf(stdout,"Mode de developpement...\n");
    luaL_dofile(L,"makeClean.lua"); //dev
#else
    luaL_dofile(L,"/usr/local/share/ASCluaUtils/makeClean.luac");
#endif
    //Mode normal 
    if(argc == 1){ //On make clean le dossier courant
        lua_getglobal(L,"clean");
        lua_pushstring(L,".");
    }else if(argc==2 && gFS_isDir(*(argv+1))){ //On make clean dossier en argument
        lua_getglobal(L,"clean");
        lua_pushstring(L,*(argv+1));
    }else{
        manuel();
        lua_close(L);
        return 1;
    }
    lua_call(L,1,0);
    lua_close(L);
    return 0;
}

void manuel(void){
    fprintf(stderr,"This software is used to recursively execute the make clean function in a directory.\n    Usage: makeclean <directory>\nIf no directory is given the current directory will be targeted.\n");
}

