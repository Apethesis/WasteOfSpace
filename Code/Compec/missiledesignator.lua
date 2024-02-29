local keyboard = GetPartFromPort(1,"Keyboard")
local antenna = GetPartFromPort(1, "Port")
local speaker = GetPartFromPort(1, "Speaker")
local statusLight = GetPartFromPort(1, "Light"); statusLight:SetColor(Color3.fromRGB(255,0,0))
local sNoneColor = Color3.fromRGB(255,0,0)
local sIdleColor = Color3.fromRGB(0,0,255)
local sLastColor
local mislist = { existing = {} }
antenna:Connect("Triggered", function(part)
    if not mislist.existing[part.GUID] then
        mislist.existing[part.GUID] = true
        mislist[#mislist+1] = { gyroTrigger = GetPartFromPort(part,"Port"), GUID = part.GUID, anchor = GetPartFromPort(part,"Anchor"), gyro = GetPartFromPort(part,"Gyro"), fuelValve = GetPartFromPort(part,"Valve") }
        local triggers = GetPartsFromPort(part,"TriggerSwitch")
        for k,v in pairs(triggers) do
            if GetPartFromPort(v,"Transformer") then
                mislist[#mislist].detTrigger = v
            else
                mislist[#mislist].primaryTrigger = v
            end
        end; triggers = nil
        local misid = #mislist
        speaker:Chat("Missile "..misid.." has been added to the table.")
        if sLastColor then local finColor = sLastColor:Lerp(sIdleColor,0.016); statusLight:SetColor(finColor); sLastColor = finColor else local finColor = sNoneColor:Lerp(sIdleColor,0.016); statusLight:SetColor(finColor); sLastColor = finColor; end 
        mislist[#mislist].primaryTrigger:Connect("Triggered", function()
            speaker:Chat("Missile "..misid.." detonation wire has been triggered.")
            speaker:Chat("Removing from table...")
            local finColor = sLastColor:Lerp(sNoneColor,0.016)
            statusLight:SetColor(finColor); sLastColor = finColor
            mislist[misid] = nil
            mislist.existing[part.GUID] = nil
        end)
    end
end)
GetPort(2):Connect("Triggered", function()
    speaker:Chat("Global missile detonation signal was triggered.")
    speaker:Chat("Clearing table...")
    statusLight:SetColor(sNoneColor); sLastColor = nil
    for k,v in pairs(mislist.existing) do
        mislist.existing[k] = nil
    end
    for k,v in pairs(mislist) do
        if k ~= "existing" then
            mislist[k] = nil
        end
    end
end)
keyboard:Connect("TextInputted", function(stri, plr)
    if plr ~= "TheShotGunBoy" then return end
    stri = string.sub(stri,1,-2)
    local mid, mcmd = stri:match("^(%d+)!(.*)$"); mid = tonumber(mid)
    local args = mcmd:split(" ")
    local cmdres = table.remove(args,1)
    local defseek = "Min9.5 Maxinf TrigMin9.5 TrigMax12.5 "
    if mislist[mid] then
        if cmdres == "target" then
            speaker:Chat("Changing target of missile number "..mid.."...")
            mislist[mid].gyro:Configure({ Seek = defseek..table.concat(args, " ")})
        elseif cmdres == "detonate" then
            speaker:Chat("Detonating missile...")
            mislist[mid].detTrigger:Configure({ SwitchValue = true })
            speaker:Chat("Missile "..mid.." detonation wire has been triggered.")
            speaker:Chat("Removing from table...")
            local finColor = sLastColor:Lerp(sNoneColor,0.016)
            statusLight:SetColor(finColor); sLastColor = finColor
            mislist.existing[mislist[mid].GUID] = nil
            mislist[mid] = nil
        elseif cmdres == "launch" then
            speaker:Chat("Attempting to launch missile number "..mid)
            mislist[mid].fuelValve:Configure({ SwitchValue = true })
            mislist[mid].anchor:Configure({ Anchored = false })
            task.wait(5)
            mislist[mid].primaryTrigger:Configure({ SwitchValue = true })
            GetPartFromPort(mislist[mid].gyroTrigger, "DelayWire"):Trigger()
        elseif cmdres == "anchor" then
            mislist[mid].anchor:Configure({ Anchored = true })
        elseif cmdres == "unanchor" then
            mislist[mid].anchor:Configure({ Anchored = false })
        elseif cmdres == "drop" then
            mislist[mid].fuelValve:Configure({ SwitchValue = false })
            mislist[mid].anchor:Configure({ Anchored = false })
        end
    else
        speaker:Chat("Invalid DESSOL ID.")
    end
end)