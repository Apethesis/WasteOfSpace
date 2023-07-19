local disk = GetPartFromPort(0,"Disk")
local startport = 1
local conports = 1

local bins = {}
for port_id = startport, conports do
    bins[port_id] = GetPartsFromPort(port_id,"Bin")
end 

while wait(5) do
    for resource_id, tabl in ipairs(bins) do
        local resourceamt = 0

        for _, bin in ipairs(tabl) do
            resourceamt = resourceamt + bin:GetAmount() 
        end -- Pil you either work on the ui or you basically do nothing, your choice :P
        disk:Write(resource_id, resourceamt) -- 👍
    end
end