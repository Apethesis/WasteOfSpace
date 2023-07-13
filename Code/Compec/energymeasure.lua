local enerins = GetPartFromPort(1,"Instrument")
local screen = GetPartFromPort(2,"Screen")
local screennum = screen:CreateElement("TextLabel", {
    ["Size"] = UDim2.new(1, 0, 1, 0),
    ["TextScaled"] = true,
    ["Font"] = Enum.Font.Code,
    ["TextColor3"] = Color3.new(1,1,1),
    ["Text"] = "0",
    ["BorderSizePixel"] = 0
})
while true do
    local enercur = enerins:GetReading(4)
    wait(1.1)
    local enernext = enerins:GetReading(4)
    local enerdiff = enernext - enercur
    if enerdiff > 0 then
        screennum:ChangeProperties({
            ["TextColor3"] = Color3.new(0, 1, 0),
            ["Text"] = "+"..enerdiff
        })
    elseif enerdiff == 0 then
        screennum:ChangeProperties({
            ["TextColor3"] = Color3.new(1,1,1),
            ["Text"] = "0"
        })
    elseif enerdiff < 0 then
        screennum:ChangeProperties({
            ["TextColor3"] = Color3.new(1,0,0),
            ["Text"] = enerdiff
        })
    end
end