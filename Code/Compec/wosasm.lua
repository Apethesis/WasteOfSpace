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
        [6] = 0x00, -- R6, flag register, 0x00 is absolute, 0x01 is relative
        [7] = 0x00, -- R7, flag register, 0x00 is JMP, 0x01 is JMP if R3 zero
        [8] = 0x00, -- R8, flag register, 0x00 is LShift, 0x01 is RShift, 0x02 is ARShift
        [9] = 0x00, -- R9, flag register, 0x00 is normal, 0x01 is NOT (affects all bitwise operations except for Shift)
        [10] = 0x00, -- R10, flag register, 0x00 jumps if R3 is zero, 0x01 jumps if R3 is not zero. 0x02 jumps if R3 is greater than zero
        [11] = 0x00, -- R11, barely useful Flags register
    },
    intLimit = 2^18 -- such an arbitrary limit...
}
local mem = {}
local function toNum(num) -- Intended for easier bit manipulation
    return tonumber(num,2)
end
local bitFlags = {
    carry = toNum("1000"),
    zero = toNum("0100"),
    parity = toNum("0010"),
}
function cState:setFlag(flag,state)
    if state then
        self.reg[11] = bit32.bor(self.reg[11],bitFlags[flag])
    else
        self.reg[11] = bit32.band(self.reg[11],bit32.bnot(bitFlags[flag]))
    end
end
local function clamp(num,top,bottom,setFlag) 
    if not num then num = 0 end
    if setFlag and (num % 2) == 0 then 
        cState:setFlag("parity",true) 
    elseif setFlag and (num % 2) == 1 then 
        cState:setFlag("parity",false) 
    end
    if setFlag and num == 0 then
        cState:setFlag("zero",true) 
    else
        cState:setFlag("zero",false) 
    end
    if num > top then
        if setFlag then 
            cState:setFlag("carry",true) 
        end
        return clamp(num-top,top,bottom)
    elseif num < top and num < bottom then
        if setFlag then 
            cState:setFlag("carry",true) 
        end
        return bottom
    else
        if setFlag then 
            cState:setFlag("carry",false) 
        end
        return num
    end
end
function mem:readByte(addr)
    return self[clamp(addr,cState.intLimit,0)] or 0
end
function mem:fetchByte(addr)
    cState.reg[4] = clamp(cState.reg[4]+1,cState.intLimit,0)
    return self[cState.reg[4]-1] or 0
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
        [0x01] = function() -- SUB, subtracts R1 from R2, outputs in R3
            cState.reg[3] = clamp(cState.reg[1] - cState.reg[2],cState.intLimit, 0, true)
        end,
        [0x02] = function() -- ADD, adds R2 to R1, outputs in R3
            cState.reg[3] = clamp(cState.reg[1] + cState.reg[2],cState.intLimit, 0, true)
        end,
        [0x03] = function() -- DIV, divides R1 by R2, outputs in R3
            cState.reg[3] = clamp(cState.reg[1] / cState.reg[2],cState.intLimit, 0, true)
        end,
        [0x04] = function() -- MUL, multiplies R1 by R2, outputs in R3
            cState.reg[3] = clamp(cState.reg[1] * cState.reg[2],cState.intLimit, 0, true)
        end,
        [0x05] = function() -- AND, does a bitwise AND on R1 + R2, outputs in R3
            if cState.reg[9] == 0 then
                cState.reg[3] = clamp(bit32.band(cState.reg[1],cState.reg[2]),cState.intLimit, 0)
            else 
                cState.reg[3] = clamp(bit32.bnot(bit32.band(cState.reg[1],cState.reg[2])),cState.intLimit, 0)
            end
        end,
        [0x06] = function() -- OR, does a bitwise OR on R1 + R2, outputs in R3
            if cState.reg[9] == 0 then
                cState.reg[3] = clamp(bit32.bor(cState.reg[1],cState.reg[2]),cState.intLimit, 0)
            else
                cState.reg[3] = clamp(bit32.bnot(bit32.bor(cState.reg[1],cState.reg[2])),cState.intLimit, 0)
            end
        end,
        [0x07] = function() -- NOT, does a bitwise NOT on R1, outputs in R3
            cState.reg[3] = clamp(bit32.bnot(cState.reg[1]),cState.intLimit, 0)
        end,
        [0x08] = function() -- XOR, does a bitwise XOR on R1 + R2, outputs in R3
            if cState.reg[9] == 0 then
                cState.reg[3] = clamp(bit32.bxor(cState.reg[1],cState.reg[2]),cState.intLimit, 0)
            else
                cState.reg[3] = clamp(bit32.bnot(bit32.bxor(cState.reg[1],cState.reg[2])),cState.intLimit, 0)
            end
        end,
        [0x09] = function() -- SHF (Shift), shifts R1 by R2, outputs in R3, type of shift varies based on R8 value
            if cState.reg[8] == 0 then
                cState.reg[3] = clamp(bit32.lshift(cState.reg[1],cState.reg[2]),cState.intLimit,0)
            elseif cState.reg[8] == 1 then
                cState.reg[3] = clamp(bit32.rshift(cState.reg[1],cState.reg[2]),cState.intLimit,0)
            else
                cState.reg[3] = clamp(bit32.arshift(cState.reg[1],cState.reg[2]),cState.intLimit,0)
            end
        end,
        [0x0A] = function(memory) -- MTR, moves first arg into register chosen by second arg (1-128)
            cState.reg[clamp(memory:fetchByte(),128,1)] = clamp(memory:fetchByte(),cState.intLimit,0)
        end,
        [0x0B] = function(memory) -- MFR, moves specified register value to memory address chosen by second arg
            local d1, d2 = clamp(memory:fetchByte(),128,1), clamp(memory:fetchByte(),cState.intLimit,0)
            if cState.reg[6] == 0 then
                memory[d2] = cState.reg[d1]
            else
                memory[cState.reg[4]+d2] = cState.reg[d1]
            end
        end,
        [0x0C] = function(memory) -- MTRM, moves value of memory address chosen to register specified by second arg
            local d1, d2 = clamp(memory:fetchByte(),cState.intLimit,0), clamp(memory:fetchByte(),128,1)
            if cState.reg[6] == 0 then
                cState.reg[d2] = memory[d1]
            else
                cState.reg[cState.reg[4]+d2] = memory[d1]
            end
        end,
        [0x0D] = function(memory) -- JMP, jumps to specified address
            local jumpAddress = clamp(memory:fetchByte(),cState.intLimit,0)
            memory:stackPush(cState.reg[4])
            cState.reg[4] = jumpAddress
        end,
        [0x0E] = function(memory) -- JMC (Jump Conditional), jumps to specified address if R3 meets chosen condition
            local jumpAddress = clamp(memory:fetchByte(),cState.intLimit,0)
            if cState.reg[10] == 0x00 and cState.reg[3] == 0x00 then
                memory:stackPush(cState.reg[4])
                cState.reg[4] = jumpAddress
            elseif cState.reg[10] == 0x01 and cState.reg[3] ~= 0x00 then
                memory:stackPush(cState.reg[4])
                cState.reg[4] = jumpAddress
            elseif cState.reg[10] == 0x01 and cState.reg[3] > 0x00 then
                memory:stackPush(cState.reg[4])
                cState.reg[4] = jumpAddress
            end
        end,
        [0x0F] = function(memory) -- RET, returns from a jump
            local retAddr = memory:stackPop()
            cState.reg[4] = retAddr
        end,
        [0x10] = function(memory) -- MRE, moves one register value to another
            local d1, d2 = clamp(memory:fetchByte(),128,1), clamp(memory:fetchByte(),128,1)
            cState.reg[d2] = cState.reg[d1]
        end,
    }
    repeat
        local ins = memInput:fetchByte()
        if cState.reg[4] == cState.intLimit then
            finished = true
            break
        end
        if ins ~= 0x00 then
            if ins > 0x00 and ins < 0x10 then
                instTable[ins](memInput)
            end
        end
    until finished
end
-- Now go on, do whatever here
-- I will leave a default here.
readDisk(rom)
exec(mem)