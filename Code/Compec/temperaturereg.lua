local coolers = GetPartsFromPort(1, "Switch")
local heaters = GetPartsFromPort(2, "Switch")
local instrument = GetPartFromPort(4, "Instrument")
local diff = 0
for k,v in pairs(coolers) do
    v:Configure({ SwitchValue = false })
end
for k,v in pairs(heaters) do
    v:Configure({ SwitchValue = false })
end
local function adjustswitch(am)
    if am == 0 then
        diff = 0
        for k,v in pairs(coolers) do
            v:Configure({ SwitchValue = false })
        end
        for k,v in pairs(heaters) do
            v:Configure({ SwitchValue = false })
        end
    elseif am > 0 then
        diff = 0
        for k,v in pairs(coolers) do
            v:Configure({ SwitchValue = false })
        end
        for i=1,am do
            diff = diff - 10
            heaters[i]:Configure({ SwitchValue = true })
        end
    elseif am < 0 then
        diff = 0
        am = math.abs(am)
        for k,v in pairs(heaters) do
            v:Configure({ SwitchValue = false })
        end
        for i=1,am do
            diff = diff + 20
            coolers[i]:Configure({ SwitchValue = true })
        end
    end
    return am
end
while true do
    local curread = instrument:GetReading(7)
    print(curread)
    print(curread+diff)
    if instrument:GetReading(7) < (30-diff) then 
        print(adjustswitch(math.round((math.abs(instrument:GetReading(7)-30)-diff)/10)))
    elseif instrument:GetReading(7) > (90-diff) then
        print(adjustswitch(-(math.round(((instrument:GetReading(7)-90)+diff)/20))))
    elseif diff == 0 then
        adjustswitch(0)
    end
    if instrument:GetReading(0) > 750 then
        TriggerPort(3)
    end
    task.wait(2)
end