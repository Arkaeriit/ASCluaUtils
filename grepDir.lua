
function grepDir(exp,dir,flagRec)
    local ret = false --indique si on a affiché au moins une fois quelque-chose
    if dir:sub(#dir,#dir) ~= "/" then
        dir = dir.."/"
    end
    local listFiles = ls(dir);
    for i = 1,#listFiles do
        if not isDir(dir..listFiles[i]) then
            local grep = io.popen("cat "..dir..antiSlashing(listFiles[i]).." | grep "..exp,"r")
            local str = grep:read()
            if str then --On vérifie que l'on a au moins un résultat avent d'afficher le nom du fichier
                print(listFiles[i]..":")
                while str do
                    print(str)
                    str = grep:read()
                end
                print("")
                ret = true
            end
        elseif flagRec then
            local resrec = grepDir(exp,dir..listFiles[i],true)
            if resrec then
                ret = true
            end
        end
    end
    return ret
end


function antiSlashing(string) --renvoie une chaine qui est comme string mais avec un anti-slash avant chaque charctère qui causerait un problème
    local ret = ""
    for i=1,#string do
        local char = string:sub(i,i)
        if char == " " or char == '"' or char == "'" or char == "`" or char == "\\" or char == "(" or char == ")" or char == "&" or char == "|" or char == "#" or char == "$" or char == "*" or char == "^" or char == "?" or char == "~" or char ==  "!" or char == "<" or char == ">" or char == ";" then --On regarde si un des charactères pose problème. Si s'est le cas on met un \ devant
            ret=ret.."\\"..char
        else
            ret=ret..char
        end
    end
    return ret
end

