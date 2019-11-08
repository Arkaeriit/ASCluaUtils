
function clean(dossier)
    local f = io.popen("cd "..antiSlashing(dossier).." && pwd","r") --dossier de départ du travail
    local dossierBase = f:read()
    f:close()

    cleanRec(dossierBase)
end


function cleanRec(dossier)
    if dossier:sub(#dossier,#dossier) ~= "/" then
        dossier = dossier.."/"
    end
    os.execute("cd "..antiSlashing(dossier).." && make clean &> /dev/null")
    
    local files = ls(dossier)
    for i=1,#files do
        if isDir(dossier..files[i]) and files[i] ~= ".mozilla" and files[i] ~= ".mozilla/" and files[i] ~= ".Trash" and files[i] ~= ".Trash/" then
            cleanRec(dossier..files[i])
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

