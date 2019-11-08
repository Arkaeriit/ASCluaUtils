
function grepDir(exp,dir,flagRec)
print("lol")
    if dir:sub(#dir,#dir) ~= "/" then
        dir = dir.."/"
    end
    local listFiles = ls(dir);
    for i = 1,#listFiles do
        if not isDir(dir..listFiles[i]) then
            print(listFiles[i]..":")
            os.execute("cat "..dir..antiSlashing(listFiles[i]).." | grep "..exp)
        print("")
        elseif flagRec then
            grepDir(exp,dir..listFiles[i],true)
        end
    end
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

