local instructions = {
    ["nop"] = 0x00,
    ["sub"] = 0x01,
    ["add"] = 0x02,
    ["div"] = 0x03,
    ["mul"] = 0x04,
    ["and"] = 0x05,
    ["or"] = 0x06,
    ["not"] = 0x07,
    ["xor"] = 0x08,
    ["shf"] = 0x09,
    ["mtr"] = 0x0A,
    ["mfr"] = 0x0B,
    ["mtrm"] = 0x0C,
    ["jmp"] = 0x0D,
    ["jmc"] = 0x0E,
    ["ret"] = 0x0F,
    ["mre"] = 0x10,
    ["imm"] = 0x11,
    ["mmo"] = 0x12
}
local function toNum(num)
    return tonumber(num,2)
end
if #arg == 0 then
    io.write("Usage:\n")
    io.write("  lua wasm.lua <input> <output>\n")
    io.write("  lua wasm.lua input.wasm output.wos")
    return
end
local packUp = ">I3"
local fl = io.open(arg[2],"w+b")
for line in io.lines(arg[1]) do
    for token in string.gmatch(line, "%w+") do
        if token == "//" then
            break
        else
            if string.sub(token,1,2) == "$r" then
                fl:write(string.pack(packUp,tonumber(string.sub(token,3))))
            elseif string.sub(token,1,2) == "0b" then
                fl:write(string.pack(packUp,toNum(string.sub(token,3))))
            elseif instructions[string.lower(token)] then
                fl:write(string.pack(packUp,instructions[string.lower(token)]))
            elseif tonumber(token) then
                fl:write(string.pack(packUp,tonumber(token)))
            else
                for i=1,#token do
                    fl:write(string.pack(packUp,string.byte(token,i)))
                end
            end
        end
    end
end
fl:close()