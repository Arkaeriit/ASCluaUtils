
function clean(dossier,boolPDF)
    local deletable = {".aux",".toc",".log",".out",".synctex.gz"} --à compléter
    if dossier:sub(#dossier,#dossier) ~= "/" then
        dossier = dossier.."/"
    end

    local files = ls(dossier)
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
            rm(dossier..texLS[i]..deletable[j])
        end
        if boolPDF then
            rm(dossier..texLS[i]..".ps")
            rm(dossier..texLS[i]..".pdf")
        end
    end
end

