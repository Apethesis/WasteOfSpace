local keyboard = GetPartFromPort(1,"Keyboard")
local antenna = GetPartFromPort(1, "Antenna")
local speaker = GetPartFromPort(1, "Speaker")
local mislist = { existing = {} }
antenna:Connect("Triggered", function(part)
    if not mislist.existing[part.GUID] then
        mislist.existing[part.GUID] = true
        table.insert(mislist,{ detTriggerWire = GetPartFromPort(part,"TriggerWire"), anchor = GetPartFromPort(part,"Anchor"), gyro = GetPartFromPort(part,"Gyro"), detTrigger = GetPartFromPort(part,"TriggerSwitch"), fuelValve = GetPartFromPort(part,"Valve") })
        local misid = #mislist
        mislist[#mislist].detTriggerWire:Connect("Triggered", function()
            speaker:Chat("Missile "..misid.." detonation wire has been triggered.")
            speaker:Chat("Removing from table...")
            table.remove(mislist, misid)
            mislist.existing[part.GUID] = nil
        end)
    end
end)
keyboard:Connect("TextInputted", function(stri, plr)
    if plr ~= "TheShotGunBoy" then return end
    stri = string.sub(stri,1,-2)
    local i1, i2 = string.find(stri,"!")
    local mid = tonumber(string.sub(stri,1,i1-1))
    local mcmd = string.sub(stri,i2+1)
    if mislist[mid] then
        if string.sub(mcmd,1,6) == "target" then
            mislist[mid].gyro:Configure({ Seek = "Min9.5 Maxinf TrigMin9.5 TrigMax12.5"..string.sub(mcmd,7)})
        elseif string.sub(mcmd,1,8) == "detonate" then
            mislist[mid].detTrigger:Configure({ SwitchValue = true })
        elseif string.sub(mcmd,1,5) == "launch" then
            if mislist[mid].fuelValve.SwitchValue then
                speaker:Chat("Missile has already been launched, or is in default state.")
                speaker:Chat("Attempting launch anyways...")
                mislist[mid].fuelValve:Configure({ SwitchValue = true })
                mislist[mid].anchor:Configure({ Anchored = false })
            else
                speaker:Chat("Launching missile number "..mid)
                mislist[mid].fuelValve:Configure({ SwitchValue = true })
                mislist[mid].anchor:Configure({ Anchored = false })
            end
        elseif string.sub(mcmd,1,6) == "anchor" then
            mislist[mid].Anchor:Configure({ Anchored = true })
        elseif string.sub(mcmd,1,8) == "unanchor" then
            mislist[mid].Anchor:Configure({ Anchored = false })
        elseif string.sub(mcmd,1,4) == "drop" then
            mislist[mid].fuelValve:Configure({ SwitchValue = false })
            mislist[mid].Anchor:Configure({ Anchored = false })
        end
    else
        speaker:Chat("Invalid DESSOL ID.")
    end
end)