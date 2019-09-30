
function clean(boolPDF)
    print("1")
    local files = ls(".")
    print(2)
    local texLS = {}
    for i=1,#files do
        local extention = files[i]:sub(#files[i] - 3,#files[i])
        local nom = files[i]:sub(1,#files[i] - 4)
        print(nom,extention)
    end
    print(boolPDF)
end

