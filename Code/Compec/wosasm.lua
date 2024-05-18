local rom = GetPartFromPort(1,"Disk") or error("Requires a disk on port ID 1.")
local function libbit32() local bit32 = {} local w=32 local V=2^w function bit32.bnot(w)w=w%V return(V-1)-w end function bit32.band(R,k)if k==255 then return R%256 end if k==65535 then return R%65536 end if k==4294967295 then return R%4294967295 end R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H==2 then M=M+P end P=2*P end return M end function bit32.bor(R,k)if k==255 then return(R-R%256)+255 end if k==65535 then return(R-R%65536)+65535 end if k==4294967295 then return 4294967295 end R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H>=1 then M=M+P end P=2*P end return M end function bit32.bxor(R,k)R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H==1 then M=M+P end P=2*P end return M end function bit32.lshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k<0 then return math.floor(R*2^k)else return(R*2^k)%V end end function bit32.rshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k>0 then return math.floor(R*2^(-k))else return(R*2^(-k))%V end end function bit32.arshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k>0 then local M=0 if R>=V/2 then M=V-2^(w-k)end return math.floor(R*2^(-k))+M else return(R*2^(-k))%V end end return bit32; end
local bit32 = libbit32()
local cState = {
    reg = {
        [1] = 0x00, -- R1, first input for math/binary manipulation.
        [2] = 0x00, -- R2, second input for math/binary manipulation.
        [3] = 0x00, -- R3, output for math/binary manipulation.
        [4] = 0x01, -- R4, program counter.
        [5] = 2^18, -- R5, stack pointer, referencing the memory intLimit.
    },
    intLimit = 2^18 -- such an arbitrary limit...
}
local mem = {}
local function clamp(num,top,bottom) 
    if not num then num = 0 end
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
    cState.reg[4] = clamp(cState.reg[4]+1,cState.intLimit,0)
    return mem[cState.reg[4]-1] or 0
end
function mem:stackPush(data)
    mem[cState.reg[5]] = clamp(data,cState.intLimit,0)
    cState.reg[5] -= 1
end
function mem:stackPop()
    local tempData = mem[cState.reg[5]]
    cState.reg[5] += 1
    mem[cState.reg[5]-1] = 0
    return tempData
end
local function readDisk(disk)
    local tempROM = rom:ReadEntireDisk()
    assert(tempROM.progEnd,"Disk program invalid, missing progEnd.")
    if tempROM.progEnd > cState.intLimit-1 then error("Disk program invalid, progEnd exceeds memory limit.") end
    for i=1,tempROM.progEnd do
        local data = assert(tempROM[tostring(i)],"Invalid data in rom at memory address "..string.format("%x", i))
        mem[i] = clamp(data,cState.intLimit,0)
    end
end
local function exec(memInput)
    local finished = false
    local instTable = {

    }
end