-- Written by the wise ddorpg, Minified by Prometheus
local function s256() local W=4294967296 local l=W-1 local v=bit32_band or bit32.band or error("\110\111 \098\105\116\051\050 \108\105\098\114\097\114\121\063")local Z=lshift or bit32.lshift or error("\110\111 \098\105\116\051\050 \108\105\098\114\097\114\121\063")local function u(W)local l={}local v=setmetatable({},l)function l.__index(Z,l)local u=W(l)v[l]=u return u end return v end local function k(W,l)local function v(v,Z)local u,k=0,1 while v~=0 and Z~=0 do local Q,A=v%l,Z%l u=u+W[Q][A]*k v=(v-Q)/l Z=(Z-A)/l k=k*l end u=u+(v+Z)*k return u end return v end local function Q(W)local l=k(W,2)local v=u(function(W)return u(function(v)return l(W,v)end)end)return k(v,2^(W.n or 1))end local A=Q({[0]={[0]=0,[1]=1};[1]={[0]=1,[1]=0},n=4})local function K(l,v,Z,...)local u=nil if v then l=l%W v=v%W u=A(l,v)if Z then u=K(u,Z,...)end return u elseif l then return l%W else return 0 end end local function o(Z,u,k,...)local Q if u then Z=Z%W u=u%W Q=((Z+u)-A(Z,u))/2 if k then Q=v(Q,k,...)end return Q elseif Z then return Z%W else return l end end local function s(l)return(-1-l)%W end local function j(W,l)if l<0 then return Z(W,-l)end return math.floor((W%4294967296)/2^l)end local function F(l,v)if v>31 or v<-31 then return 0 end return j(l%W,v)end local function a(W,l)if l<0 then return F(W,-l)end return(W*2^l)%4294967296 end local function b(l,v)l=l%W v=v%32 local Z=o(l,2^v-1)return F(l,v)+a(Z,32-v)end local C={1116352408;1899447441;3049323471;3921009573;961987163;1508970993,2453635748,2870763221,3624381080,310598401,607225278,1426881987,1925078388;2162078206,2614888103,3248222580,3835390401;4022224774;264347078;604807628,770255983;1249150122;1555081692;1996064986,2554220882;2821834349;2952996808,3210313671,3336571891,3584528711,113926993;338241895,666307205;773529912;1294757372,1396182291;1695183700;1986661051,2177026350,2456956037,2730485921;2820302411;3259730800,3345764771,3516065817,3600352804;4094571909;275423344,430227734;506948616;659060556,883997877;958139571,1322822218,1537002063,1747873779;1955562222,2024104815;2227730452;2361852424,2428436474;2756734187,3204031479,3329325298}local function H(W)return string.gsub(W,"\046",function(W)return string.format("\037\048\050\120",string.byte(W))end)end local function y(W,l)local v=""for l=1,l,1 do local Z=W%256 v=string.char(Z)..v W=(W-Z)/256 end return v end local function J(W,l)local v=0 for l=l,l+3,1 do v=v*256+string.byte(W,l)end return v end local function c(W,l)local v=64-(l+9)%64 l=y(8*l,8)W=W..("\128"..(string.rep("\000",v)..l))assert(#W%64==0)return W end local function P(W)W[1]=1779033703 W[2]=3144134277 W[3]=1013904242 W[4]=2773480762 W[5]=1359893119 W[6]=2600822924 W[7]=528734635 W[8]=1541459225 return W end local function h(W,l,v)local Z={}for v=1,16,1 do Z[v]=J(W,l+(v-1)*4)end for W=17,64,1 do local l=Z[W-15]local v=K(b(l,7),b(l,18),F(l,3))l=Z[W-2]Z[W]=((Z[W-16]+v)+Z[W-7])+K(b(l,17),b(l,19),F(l,10))end local u,k,Q,A,j,a,H,y=v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8]for W=1,64,1 do local l=K(b(u,2),b(u,13),b(u,22))local v=K(o(u,k),o(u,Q),o(k,Q))local F=l+v local J=K(b(j,6),b(j,11),b(j,25))local c=K(o(j,a),o(s(j),H))local P=(((y+J)+c)+C[W])+Z[W]y,H,a,j,A,Q,k,u=H,a,j,A+P,Q,k,u,P+F end v[1]=o(v[1]+u)v[2]=o(v[2]+k)v[3]=o(v[3]+Q)v[4]=o(v[4]+A)v[5]=o(v[5]+j)v[6]=o(v[6]+a)v[7]=o(v[7]+H)v[8]=o(v[8]+y)end local function d(W)W=c(W,#W)local l=P({})for v=1,#W,64 do h(W,v,l)end return H(y(l[1],4)..(y(l[2],4)..(y(l[3],4)..(y(l[4],4)..(y(l[5],4)..(y(l[6],4)..(y(l[7],4)..y(l[8],4))))))))end return SHA256; end