local reactor = GetPartFromPort(1, "Reactor")
local dispenser = GetPartFromPort(2, "Dispenser")
local instrument = GetPartFromPort(3, "Instrument")

while true do
    if instrument:GetReading(4) < 306667 then
        if reactor:GetTemp() > 1000 then
            TriggerPort(4)

        elseif reactor:GetTemp() < 1000 then
            TriggerPort(5)

        elseif instrument:GetReading(4) > 306667 then
            TriggerPort(5)
        end

    else
        TriggerPort(4)
    end

    for _, amt in pairs(reactor:GetFuel()) do
        if amt == 0 then
            dispenser:Dispense()
        end
    end
    wait(1)
end