local reactor = GetPartFromPort(1, "Reactor")
local dispenser = GetPartFromPort(2, "Dispenser")
local instrument = GetPartFromPort(3, "Instrument")
local polyactivate = GetPartFromPort(4, "Polysilicon")
local polydeactivate = GetPartFromPort(5, "Polysilicon")
while task.wait(1) do
    if reactor:GetTemp() < 1000 and reactor:GetTemp() >= 0 and instrument:GetReading(4) < 306667 then
        polyactivate:Trigger()
    elseif reactor:GetTemp() > 1000 then
        polydeactivate:Trigger()
    elseif instrument:GetReading(4) > 306667 then
        polydeactivate:Trigger()
    end
    for _, amt in pairs(reactor:GetFuel()) do
        if amt == 0 then
            dispenser:Dispense()
        end
    end
end