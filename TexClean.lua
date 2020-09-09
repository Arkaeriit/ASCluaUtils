local gFS = require("gestionFS")

function clean(dossier,boolPDF)
    local deletable = {".aux",".toc",".log",".out",".synctex.gz"} --à compléter
    if dossier:sub(#dossier,#dossier) ~= "/" then
        dossier = dossier.."/"
    end

    local files = gFS.ls(dossier)
    local texLS = {}
    for i=1,#files do
        local extention = files[i]:sub(#files[i] - 3,#files[i])
        local nom = files[i]:sub(1,#files[i] - 4)
        if extention == ".tex" then
            texLS[#texLS + 1] = nom
        end
    end
    for i=1,#texLS do
        for j=1,#deletable do
            gFS.rm(dossier..texLS[i]..deletable[j])
        end
        if boolPDF then
            gFS.rm(dossier..texLS[i]..".ps")
            gFS.rm(dossier..texLS[i]..".pdf")
        end
    end
end

function make(dossier)
     if dossier:sub(#dossier,#dossier) ~= "/" then
        dossier = dossier.."/"
    end
    local files = gFS.ls(dossier)
    for i=1,#files do
        local extention = files[i]:sub(#files[i] - 3,#files[i])
        local nomCmp = files[i]
        if extention == ".tex" then
            print("pdflatex -output-directory="..dossier.." "..dossier..nomCmp)
            --os.execute("pdflatex -output-directory="..dossier.." "..dossier..nomCmp)
            os.execute("cd "..dossier.." && pdflatex "..dossier..nomCmp)
        end
    end
end

function cleanRec(dossier,boolPDF)
    if dossier:sub(#dossier,#dossier) ~= "/" then
        dossier = dossier.."/"
    end
    clean(dossier,boolPDF)
    local files = gFS.ls(dossier)
    for i=1,#files do
        if gFS.isDir(dossier..files[i]) then
            cleanRec(dossier..files[i],boolPDF)
        end
    end
end

function makeRec(dossier)
    if dossier:sub(#dossier,#dossier) ~= "/" then
        dossier = dossier.."/"
    end
    make(dossier)
    local files = gFS.ls(dossier)
    for i=1,#files do
        if isDir(dossier..files[i]) then
            makeRec(dossier..files[i])
        end
    end
end

