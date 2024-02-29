local keyboard = GetPartFromPort(1,"Keyboard")
local antenna = GetPartFromPort(1, "Port")
local speaker = GetPartFromPort(1, "Speaker")
local mislist = { existing = {} }
antenna:Connect("Triggered", function(part)
    if not mislist.existing[part.GUID] then
        mislist.existing[part.GUID] = true
        mislist[#mislist+1] = { GUID = part.GUID, detTriggerWire = GetPartFromPort(part,"Port"), anchor = GetPartFromPort(part,"Anchor"), gyro = GetPartFromPort(part,"Gyro"), detTrigger = GetPartFromPort(part,"TriggerSwitch"), fuelValve = GetPartFromPort(part,"Valve") }
        local misid = #mislist
        speaker:Chat("Missile "..misid.." has been added to the table.")
        mislist[#mislist].detTriggerWire:Connect("Triggered", function()
            speaker:Chat("Missile "..misid.." detonation wire has been triggered.")
            speaker:Chat("Removing from table...")
            mislist[misid] = nil
            mislist.existing[part.GUID] = nil
        end)
    end
end)
GetPort(2):Connect("Triggered", function()
    speaker:Chat("Global missile detonation signal was triggered.")
    speaker:Chat("Clearing table...")
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
            mislist.existing[mislist[mid].GUID] = nil
            mislist[mid] = nil
        elseif cmdres == "launch" then
            speaker:Chat("Attempting to launch missile number "..mid)
            mislist[mid].fuelValve:Configure({ SwitchValue = true })
            mislist[mid].anchor:Configure({ Anchored = false })
        elseif cmdres == "anchor" then
            mislist[mid].Anchor:Configure({ Anchored = true })
        elseif cmdres == "unanchor" then
            mislist[mid].Anchor:Configure({ Anchored = false })
        elseif cmdres == "drop" then
            mislist[mid].fuelValve:Configure({ SwitchValue = false })
            mislist[mid].Anchor:Configure({ Anchored = false })
        end
    else
        speaker:Chat("Invalid DESSOL ID.")
    end
end)