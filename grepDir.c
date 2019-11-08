#include "gestionFS.h"

#define devel 0

void manuel(void);

int main(int argc,char** argv){
    //L est la machine lua principale
    lua_State* L;
    L = luaL_newstate();
    luaL_openlibs(L);
    gFS_include(L);

    //On charge les fichiers
#if devel == 1
    fprintf(stdout,"Mode de developpement...\n");
    luaL_dofile(L,"grepDir.lua"); //dev
#else
    luaL_dofile(L,"/usr/local/share/grepDir/grepDir.luac");
#endif
    //Mode normal 
    lua_getglobal(L,"grepDir");
    if(argc == 2){ //On a donné une expression mais rien d'autre
        lua_pushstring(L,*(argv+1));
        lua_pushstring(L,".");
        lua_pushboolean(L,0);
    }else if(argc == 3){ //Ou on cherche de manière récursive ou on cherche dans un dossier
        if(strcmp(*(argv+2),"rec")){ //On donne un dossier
            lua_pushstring(L,*(argv+1));
            lua_pushstring(L,*(argv+2));
            lua_pushboolean(L,0);
        }else{ //Recherche récursive dans le dossier courant
            lua_pushstring(L,*(argv+1));
            lua_pushstring(L,".");
            lua_pushboolean(L,1);
        }
    }else if(argc == 4 && !strcmp(*(argv+2),"rec")){ //recherhe récursive dans un dossier spécial
        lua_pushstring(L,*(argv+1));
        lua_pushstring(L,*(argv+3));
        lua_pushboolean(L,1);
    }else{
        manuel();
        lua_close(L);
        return 1;
    }
    lua_call(L,3,0);
    lua_close(L);
    return 0;
}

void manuel(void){
    fprintf(stderr,"This software is used to search a regular expression in all the file of a directory and print them nicely.\n    Usage : grepDir [expression] <option> <directory>\n    If no directory is given the search will be made in the curent directory.\nAvailable options:\n    recursive : search recursively\n");
}

