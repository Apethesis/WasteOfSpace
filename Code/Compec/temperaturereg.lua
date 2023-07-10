local coolers = GetPartsFromPort(1,"Cooler")
local heaters = GetPartsFromPort(2,"Heater")
local tempmeasure = GetPartFromPort(3,"Instrument")
while true do
    local temp = tempmeasure:GetReading(2)
    if type(temp) == "string" then temp = tonumber(temp) end
    if temp >= 306 then
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
    elseif temp >= 286 and temp <= 305 then
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
    elseif temp >= 266 and temp <= 285 then
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
    elseif temp >= 246 and temp <= 265 then
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
    elseif temp >= 226 and temp <= 245 then
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
    elseif temp >= 206 and temp <= 225 then
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
    elseif temp >= 186 and temp <= 205 then
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
    elseif temp >= 166 and temp <= 185 then
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
    elseif temp >= 146 and temp <= 165 then
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
    elseif temp >= 126 and temp <= 145 then
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
    elseif temp <= 24 and temp >= 15 then
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
    elseif temp <= 14 and temp >= 5 then
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
    elseif temp <= 4 and temp >= -13 then
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
    elseif temp <= -14 and temp >= -23 then
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
    elseif temp <= -24 and temp >= -33 then
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
    elseif temp <= -34 and temp >= -43 then
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
    elseif temp <= -44 and temp >= -53 then
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
    elseif temp <= -54 and temp >= -63 then
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
    elseif temp <= -64 and temp >= -73 then
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
    elseif temp <= -74 then
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
    wait(1.1)
end