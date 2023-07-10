local coolers = GetPartsFromPort(1,"Cooler")
local heaters = GetPartsFromPort(2,"Heater")
local tempmeasure = GetPartFromPort(3,"Instrument")
while true do
    local temp = tempmeasure:GetReading(2)
    if type(temp) == "string" then temp = tonumber(temp) end
    if temp == 306 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 10
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 286 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 9
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 266 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 8
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 246 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 7
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 226 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 6
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 206 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 5
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 186 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 4
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 166 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 3
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 146 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 2
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 126 then
        for k,v in pairs(heaters) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 1
        for k,v in pairs(coolers) do
            if cur >= max then break end
            cur = cur + 1
            coolers[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 24 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 1
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == 4 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 2
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -16 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 3
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -36 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 4
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -56 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 5
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -76 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 6
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -96 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 7
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -116 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 8
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -136 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 9
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    elseif temp == -156 then
        for k,v in pairs(coolers) do
            v:Configure({["SwitchValue"] = false})
        end
        local cur = 0
        local max = 10
        for k,v in pairs(heaters) do
            if cur >= max then break end
            cur = cur + 1
            heaters[cur]:Configure({["SwitchValue"] = true})
        end
    end
end