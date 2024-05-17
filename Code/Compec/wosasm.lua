local mem = {}
local cState = {
    reg = {},
    progCount = 0x01,
    intLimit = 2^18 -- such an arbitrary limit...
}
local function clamp(num,top,bottom) 
    if num > top then
        return clamp(num-top,top,bottom)
    elseif num < top and num < bottom then
        return bottom
    else
        return num
    end
end
local function readByte(addr)
    return mem[clamp(addr,cState.intLimit,0)] or 0
end
local function fetchByte(addr)
    cState.progCount = clamp(cState.progCount+1,cState.intLimit,0)
    return mem[cState.progCount-1] or 0
end