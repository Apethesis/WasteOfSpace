-- Made by some smart fellas from minetest-mods (https://github.com/minetest-mods/turtle), Minified using Prometheus (https://github.com/prometheus-lua/Prometheus)
local function libbit32() local bit32 = {} local w=32 local V=2^w function bit32.bnot(w)w=w%V return(V-1)-w end function bit32.band(R,k)if k==255 then return R%256 end if k==65535 then return R%65536 end if k==4294967295 then return R%4294967295 end R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H==2 then M=M+P end P=2*P end return M end function bit32.bor(R,k)if k==255 then return(R-R%256)+255 end if k==65535 then return(R-R%65536)+65535 end if k==4294967295 then return 4294967295 end R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H>=1 then M=M+P end P=2*P end return M end function bit32.bxor(R,k)R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H==1 then M=M+P end P=2*P end return M end function bit32.lshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k<0 then return math.floor(R*2^k)else return(R*2^k)%V end end function bit32.rshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k>0 then return math.floor(R*2^(-k))else return(R*2^(-k))%V end end function bit32.arshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k>0 then local M=0 if R>=V/2 then M=V-2^(w-k)end return math.floor(R*2^(-k))+M else return(R*2^(-k))%V end end end