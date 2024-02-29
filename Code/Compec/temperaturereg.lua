local coolers = GetPartsFromPort(1, "Switch")
local heaters = GetPartsFromPort(1, "Switch")
local instrument = GetPartFromPort(4, "Instrument")
local function adjustswitch(am)
    if am == 0 then
        for k,v in ipairs(coolers) do
            v:Configure({ SwitchValue = false })
        end
        for k,v in ipairs(heaters) do
            v:Configure({ SwitchValue = false })
        end
    elseif am > 0 then
        for k,v in ipairs(coolers) do
            v:Configure({ SwitchValue = false })
        end
        for i=1,am do
            heaters[i]:Configure({ SwitchValue = true })
        end
    elseif am < 0 then
        for k,v in ipairs(heaters) do
            v:Configure({ SwitchValue = false })
        end
        for i=1,am do
            coolers[i]:Configure({ SwitchValue = true })
        end
    end
    return am
end
while true do
    if instrument:GetReading(7) < 0 then
        print(adjustswitch(math.round(instrument:GetReading(7)/20)))
    elseif instrument:GetReading(7) > 70 then
        print(adjustswitch(-(math.round(instrument:GetReading(7)/10))))
    else
        adjustswitch(0)
    end
    if instrument:GetReading(0) > 750 then
        TriggerPort(3)
    end
    task.wait(1)
end