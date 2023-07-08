local extractor = GetPartFromPort(1,"Extractor")
local mat = {"Stone","Silicon","Sulfur","Flint","Oil","Ruby","Ice","Quartz"}
local cur = 1
while true do
    extractor:Configure({["MaterialToExtract"] = mat[cur]})
    cur = cur + 1
    if cur > #mat then
        cur = 1
    end
    wait(10.1)
end