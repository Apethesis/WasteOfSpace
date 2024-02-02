local disk = GetPartFromPort(1, "Disk")
local screen = GetPartFromPort(1, "Screen")
local keyboard = GetPartFromPort(1, "Keyboard")
local function libbit32() local bit32 = {} local w=32 local V=2^w function bit32.bnot(w)w=w%V return(V-1)-w end function bit32.band(R,k)if k==255 then return R%256 end if k==65535 then return R%65536 end if k==4294967295 then return R%4294967295 end R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H==2 then M=M+P end P=2*P end return M end function bit32.bor(R,k)if k==255 then return(R-R%256)+255 end if k==65535 then return(R-R%65536)+65535 end if k==4294967295 then return 4294967295 end R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H>=1 then M=M+P end P=2*P end return M end function bit32.bxor(R,k)R,k=R%V,k%V local M=0 local P=1 for w=1,w,1 do local V,H=R%2,k%2 R,k=math.floor(R/2),math.floor(k/2)if V+H==1 then M=M+P end P=2*P end return M end function bit32.lshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k<0 then return math.floor(R*2^k)else return(R*2^k)%V end end function bit32.rshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k>0 then return math.floor(R*2^(-k))else return(R*2^(-k))%V end end function bit32.arshift(R,k)if math.abs(k)>=w then return 0 end R=R%V if k>0 then local M=0 if R>=V/2 then M=V-2^(w-k)end return math.floor(R*2^(-k))+M else return(R*2^(-k))%V end end return bit32; end
local bit32 = libbit32()
local function aeslib() local u={99;124,119,123;242,107;111,197;48,1,103;43,254;215;171;118,202,130;201;125,250,89;71;240;173,212,162;175,156;164;114,192,183,253,147;38;54,63;247,204,52;165;229;241;113,216,49,21,4,199;35;195;24,150;5,154;7;18,128,226;235;39;178,117,9;131,44;26;27,110,90;160,82;59;214;179,41,227;47,132;83;209;0,237,32;252;177,91;106;203;190,57;74,76;88;207,208;239,170,251,67,77;51,133;69,249;2,127;80;60,159;168;81;163;64,143;146,157;56,245,188,182;218;33;16;255,243;210,205,12,19,236;95,151,68;23,196;167,126,61,100,93,25;115;96,129;79,220;34;42;144;136,70,238,184;20;222,94,11;219;224,50,58,10;73,6;36,92,194;211,172,98;145;149,228;121;231,200;55;109;141,213;78,169;108,86;244,234,101;122,174,8;186,120;37,46;28;166;180;198;232,221,116;31;75;189;139,138,112;62;181;102;72,3,246;14;97,53,87,185,134,193;29;158,225,248;152;17,105;217;142,148;155;30;135;233,206;85;40,223;140;161,137;13;191,230;66,104;65;153;45,15,176,84,187,22}local O={82;9;106,213,48,54;165,56,191,64;163;158,129,243,215,251,124,227,57;130;155,47;255;135;52,142;67;68,196,222;233;203;84,123;148;50;166,194;35,61;238,76;149;11;66,250,195;78;8,46;161,102;40,217,36;178;118,91;162;73;109;139,209,37,114,248,246;100,134,104;152,22;212,164,92,204;93,101;182;146,108,112,72,80;253,237;185,218;94;21;70,87;167;141;157,132,144,216,171,0;140;188,211,10,247,228;88,5;184;179;69;6,208;44;30,143,202,63;15;2,193,175;189;3;1,19,138,107,58,145;17;65,79,103;220;234;151,242;207,206,240,180,230,115;150;172,116;34;231;173,53,133,226;249,55,232,28,117;223;110,71;241,26;113;29,41;197;137,111,183;98,14;170,24;190,27,252;86,62;75,198,210,121;32;154;219;192;254;120;205;90;244;31,221,168;51,136,7;199;49,177;18,16;89,39;128,236,95;96,81,127,169,25;181,74,13,45,229,122,159;147,201,156;239;160,224,59,77,174,42;245;176;200;235,187;60;131,83,153;97;23;43;4;126,186,119,214,38,225,105,20;99;85,33;12;125}local function E(u,O)if not u then error(O)end end local h={0,1,2;4,8;16;32,64,128;27;54;108;216;171,77,154,47;94,188;99;198,151;53;106;212;179,125;250,239;197;145,57}local function U(u)local O=bit32.lshift(u,1)local E if bit32.band(u,128)==0 then E=O else E=bit32.bxor(O,27)%256 end return E end local function I(E,h)if h then h=O else h=u end for u=1,4,1 do for O=1,4,1 do E[u][O]=h[E[u][O]+1]end end end local function r(u,O)u[1][3],u[2][3],u[3][3],u[4][3]=u[3][3],u[4][3],u[1][3],u[2][3]if O then u[1][2],u[2][2],u[3][2],u[4][2]=u[4][2],u[1][2],u[2][2],u[3][2]u[1][4],u[2][4],u[3][4],u[4][4]=u[2][4],u[3][4],u[4][4],u[1][4]else u[1][2],u[2][2],u[3][2],u[4][2]=u[2][2],u[3][2],u[4][2],u[1][2]u[1][4],u[2][4],u[3][4],u[4][4]=u[4][4],u[1][4],u[2][4],u[3][4]end end local function Q(u,O)for E=1,4,1 do for h=1,4,1 do u[E][h]=bit32.bxor(u[E][h],O[E][h])end end end local function s(u,O)local E,h if O then for O=1,4,1 do E=U(U(bit32.bxor(u[O][1],u[O][3])))h=U(U(bit32.bxor(u[O][2],u[O][4])))u[O][1],u[O][2]=bit32.bxor(u[O][1],E),bit32.bxor(u[O][2],h)u[O][3],u[O][4]=bit32.bxor(u[O][3],E),bit32.bxor(u[O][4],h)end end local I for O=1,4,1 do I=u[O]E,h=bit32.bxor(I[1],I[2],I[3],I[4]),I[1]for u=1,4,1 do I[u]=bit32.bxor(I[u],E,U(bit32.bxor(I[u],I[u+1]or h)))end end end local function T(u,O,E)if E then table.move(O[1],1,4,1,u)table.move(O[2],1,4,5,u)table.move(O[3],1,4,9,u)table.move(O[4],1,4,13,u)else for E=1,#O/4,1 do table.clear(u[E])table.move(O,E*4-3,E*4,1,u[E])end end return u end local function F(u,O,E)table.clear(u)for h=1,math.min(#O,#E),1 do table.insert(u,bit32.bxor(O[h],E[h]))end return u end local function J(u,O)local E=true local h,U,I if O then h=1 else h=#u end if O then U=#u else U=1 end if O then I=1 else I=-1 end for O=h,U,I do if u[O]==255 then u[O]=0 else u[O]=u[1]+1 E=false break end end return E,u end local function e(O)local E if#O==16 then E={{};{};{};{}}elseif#O==24 then E={{},{};{},{},{};{}}else E={{},{};{},{},{},{},{},{}}end local U=T(E,O)local I=#O/4 local r,Q,s=2,{},nil while#U<(#O/4+7)*4 do s=table.clone(U[#U])if#U%I==0 then table.insert(s,table.remove(s,1))for O=1,4,1 do s[O]=u[s[O]+1]end s[1]=bit32.bxor(s[1],h[r])r=r+1 elseif#O==32 and#U%I==4 then for O=1,4,1 do s[O]=u[s[O]+1]end end table.clear(Q)F(s,table.move(s,1,4,1,Q),U[(#U-I)+1])table.insert(U,s)end table.clear(Q)for u=1,#U/4,1 do table.insert(Q,{})table.move(U,u*4-3,u*4,1,Q[#Q])end return Q end local function y(u,O,E,h,U)T(h,E)Q(h,O[1])for u=2,#u/4+6,1 do I(h)r(h)s(h)Q(h,O[u])end I(h)r(h)Q(h,O[#O])return T(U,h,true)end local function j(u,O,E,h,U)T(h,E)Q(h,O[#O])r(h,true)I(h,true)for u=#u/4+6,2,-1 do Q(h,O[u])s(h,true)r(h,true)I(h,true)end Q(h,O[1])return T(U,h,true)end local function D(u)if type(u)=="\115\116\114\105\110\103"then local O={}for E=1,string.len(u),7997 do table.move({string.byte(u,E,E+7996)},1,7997,E,O)end return O elseif type(u)=="\116\097\098\108\101"then for u,O in ipairs(u)do if not(type(O)=="\110\117\109\098\101\114"and(math.floor(O)==O and(0<=O and O<256)))then error("\085\110\097\098\108\101 \116\111 \099\097\115\116 \118\097\108\117\101 \116\111 \098\121\116\101\115")end end return u else error("\085\110\097\098\108\101 \116\111 \099\097\115\116 \118\097\108\117\101 \116\111 \098\121\116\101\115")end end local function K(u,O,h,U,I)u=D(u)if not(#u==16 or#u==24 or#u==32)then error("\075\101\121 \109\117\115\116 \098\101 \101\105\116\104\101\114 \049\054\044 \050\052 \111\114 \051\050 \098\121\116\101\115 \108\111\110\103")end O=D(O)local r if I then r="\115\101\103\109\101\110\116 \115\105\122\101 "..I else r="\049\054"end E(#O%(I or 16)==0,"\073\110\112\117\116 \109\117\115\116 \098\101 \097 \109\117\108\116\105\112\108\101 \111\102 "..(r.." \098\121\116\101\115 \105\110 \108\101\110\103\116\104"))if h then if type(U)=="\116\097\098\108\101"then U=table.clone(U)local u,O=U.Length,U.LittleEndian E(type(u)=="\110\117\109\098\101\114"and(0<u and u<=16),"\067\111\117\110\116\101\114 \118\097\108\117\101 \108\101\110\103\116\104 \109\117\115\116 \098\101 \098\101\116\119\101\101\110 \049 \097\110\100 \049\054 \098\121\116\101\115")U.Prefix=D(U.Prefix or{})U.Suffix=D(U.Suffix or{})E((#U.Prefix+#U.Suffix)+u==16,"\067\111\117\110\116\101\114 \109\117\115\116 \098\101 \049\054 \098\121\116\101\115 \108\111\110\103")if U.InitValue==nil then U.InitValue={1}else U.InitValue=table.clone(D(U.InitValue))end E(#U.InitValue<=u,"\073\110\105\116\105\097\108 \118\097\108\117\101 \108\101\110\103\116\104 \109\117\115\116 \098\101 \111\102 \116\104\101 \099\111\117\110\116\101\114 \118\097\108\117\101")if U.InitOverflow==nil then U.InitOverflow=table.create(u,0)else U.InitOverflow=table.clone(D(U.InitOverflow))end E(#U.InitOverflow<=u,"\073\110\105\116\105\097\108 \111\118\101\114\102\108\111\119 \118\097\108\117\101 \108\101\110\103\116\104 \109\117\115\116 \098\101 \111\102 \116\104\101 \099\111\117\110\116\101\114 \118\097\108\117\101")for u=1,u-#U.InitValue,1 do if O then table.insert(U.InitValue,1+#U.InitValue,0)else table.insert(U.InitValue,1,0)end end for u=1,u-#U.InitOverflow,1 do if O then table.insert(U.InitOverflow,1+#U.InitOverflow,0)else table.insert(U.InitOverflow,1,0)end end elseif type(U)~="\102\117\110\099\116\105\111\110"then local u,O if U then u,O=D(U)else u,O=table.create(16,0),{}end E(#u==16,"\067\111\117\110\116\101\114 \109\117\115\116 \098\101 \049\054 \098\121\116\101\115 \108\111\110\103")U={Length=16;Prefix=O;Suffix=O,InitValue=u,InitOverflow=table.create(16,0)}end elseif h==false then if U==nil then U=table.create(16,0)else U=D(U)end E(#U==16,"\073\110\105\116\105\097\108\105\122\097\116\105\111\110 \118\101\099\116\111\114 \109\117\115\116 \098\101 \049\054 \098\121\116\101\115 \108\111\110\103")end if I then I=math.floor(tonumber(I)or 1)E(type(I)=="\110\117\109\098\101\114"and(0<I and I<=16),"\083\101\103\109\101\110\116 \115\105\122\101 \109\117\115\116 \098\101 \098\101\116\119\101\101\110 \049 \097\110\100 \049\054 \098\121\116\101\115")end return u,O,e(u),U,I end local m={encrypt_ECB=function(u,O)local E u,O,E=K(u,O)local h,U,I,r={},{},{{},{},{};{}},{}for Q=1,#O,16 do table.move(O,Q,Q+15,1,U)table.move(y(u,E,U,I,r),1,16,Q,h)end return h end;decrypt_ECB=function(u,O)local E u,O,E=K(u,O)local h,U,I,r={},{},{{},{};{};{}},{}for Q=1,#O,16 do table.move(O,Q,Q+15,1,U)table.move(j(u,E,U,I,r),1,16,Q,h)end return h end,encrypt_CBC=function(u,O,E)local h u,O,h,E=K(u,O,false,E)local U,I,r,Q,s={},{},E,{{};{};{};{}},{}for E=1,#O,16 do table.move(O,E,E+15,1,I)table.move(y(u,h,F(s,I,r),Q,r),1,16,E,U)end return U end,decrypt_CBC=function(u,O,E)local h u,O,h,E=K(u,O,false,E)local U,I,r,Q,s={},{},E,{{};{},{};{}},{}for E=1,#O,16 do table.move(O,E,E+15,1,I)table.move(F(I,j(u,h,I,Q,s),r),1,16,E,U)table.move(O,E,E+15,1,r)end return U end;encrypt_PCBC=function(u,O,E)local h u,O,h,E=K(u,O,false,E)local U,I,r,Q,s,T={},{},E,table.create(16,0),{{};{};{},{}},{}for E=1,#O,16 do table.move(O,E,E+15,1,I)table.move(y(u,h,F(I,F(T,r,I),Q),s,r),1,16,E,U)table.move(O,E,E+15,1,Q)end return U end,decrypt_PCBC=function(u,O,E)local h u,O,h,E=K(u,O,false,E)local U,I,r,Q,s,T={},{},E,table.create(16,0),{{},{},{};{}},{}for E=1,#O,16 do table.move(O,E,E+15,1,I)table.move(F(Q,j(u,h,I,s,T),F(I,r,Q)),1,16,E,U)table.move(O,E,E+15,1,r)end return U end;encrypt_CFB=function(u,O,E,h)local U local I if h==nil then I=1 else I=h end u,O,U,E,h=K(u,O,false,E,I)local r,Q,s,T,J,e={},{},E,{},{{},{},{},{}},{}for E=1,#O,h do table.move(O,E,(E+h)-1,1,Q)table.move(F(T,y(u,U,s,J,e),Q),1,h,E,r)for u=16,h+1,-1 do table.insert(T,1,s[u])end table.move(T,1,16,1,s)end return r end;decrypt_CFB=function(u,O,E,h)local U local I if h==nil then I=1 else I=h end u,O,U,E,h=K(u,O,false,E,I)local r,Q,s,T,J,e={},{},E,{},{{},{},{};{}},{}for E=1,#O,h do table.move(O,E,(E+h)-1,1,Q)table.move(F(T,y(u,U,s,J,e),Q),1,h,E,r)for u=16,h+1,-1 do table.insert(Q,1,s[u])end table.move(Q,1,16,1,s)end return r end,encrypt_OFB=function(u,O,E)local h u,O,h,E=K(u,O,false,E)local U,I,r,Q,s={},{},E,{{},{},{},{}},{}for E=1,#O,16 do table.move(O,E,E+15,1,I)table.move(y(u,h,r,Q,s),1,16,1,r)table.move(F(s,I,r),1,16,E,U)end return U end;encrypt_CTR=function(u,O,h)local U u,O,U,h=K(u,O,true,h)local I,r,Q,s,T,e,j={},{},{},{{},{};{},{}},{},type(h)=="\116\097\098\108\101",nil for K=1,#O,16 do if e then if K>1 and J(h.InitValue,h.LittleEndian)then table.move(h.InitOverflow,1,16,1,h.InitValue)end table.clear(Q)table.move(h.Prefix,1,#h.Prefix,1,Q)table.move(h.InitValue,1,h.Length,#Q+1,Q)table.move(h.Suffix,1,#h.Suffix,#Q+1,Q)else j=D(h(Q,(K+15)/16))E(#j==16,"\067\111\117\110\116\101\114 \109\117\115\116 \098\101 \049\054 \098\121\116\101\115 \108\111\110\103")table.move(j,1,16,1,Q)end table.move(O,K,K+15,1,r)table.move(F(Q,y(u,U,Q,s,T),r),1,16,K,I)end return I end} end
local function s256() local W=4294967296 local l=W-1 local v=bit32_band or bit32.band or error("\110\111 \098\105\116\051\050 \108\105\098\114\097\114\121\063")local Z=lshift or bit32.lshift or error("\110\111 \098\105\116\051\050 \108\105\098\114\097\114\121\063")local function u(W)local l={}local v=setmetatable({},l)function l.__index(Z,l)local u=W(l)v[l]=u return u end return v end local function k(W,l)local function v(v,Z)local u,k=0,1 while v~=0 and Z~=0 do local Q,A=v%l,Z%l u=u+W[Q][A]*k v=(v-Q)/l Z=(Z-A)/l k=k*l end u=u+(v+Z)*k return u end return v end local function Q(W)local l=k(W,2)local v=u(function(W)return u(function(v)return l(W,v)end)end)return k(v,2^(W.n or 1))end local A=Q({[0]={[0]=0,[1]=1};[1]={[0]=1,[1]=0},n=4})local function K(l,v,Z,...)local u=nil if v then l=l%W v=v%W u=A(l,v)if Z then u=K(u,Z,...)end return u elseif l then return l%W else return 0 end end local function o(Z,u,k,...)local Q if u then Z=Z%W u=u%W Q=((Z+u)-A(Z,u))/2 if k then Q=v(Q,k,...)end return Q elseif Z then return Z%W else return l end end local function s(l)return(-1-l)%W end local function j(W,l)if l<0 then return Z(W,-l)end return math.floor((W%4294967296)/2^l)end local function F(l,v)if v>31 or v<-31 then return 0 end return j(l%W,v)end local function a(W,l)if l<0 then return F(W,-l)end return(W*2^l)%4294967296 end local function b(l,v)l=l%W v=v%32 local Z=o(l,2^v-1)return F(l,v)+a(Z,32-v)end local C={1116352408;1899447441;3049323471;3921009573;961987163;1508970993,2453635748,2870763221,3624381080,310598401,607225278,1426881987,1925078388;2162078206,2614888103,3248222580,3835390401;4022224774;264347078;604807628,770255983;1249150122;1555081692;1996064986,2554220882;2821834349;2952996808,3210313671,3336571891,3584528711,113926993;338241895,666307205;773529912;1294757372,1396182291;1695183700;1986661051,2177026350,2456956037,2730485921;2820302411;3259730800,3345764771,3516065817,3600352804;4094571909;275423344,430227734;506948616;659060556,883997877;958139571,1322822218,1537002063,1747873779;1955562222,2024104815;2227730452;2361852424,2428436474;2756734187,3204031479,3329325298}local function H(W)return string.gsub(W,"\046",function(W)return string.format("\037\048\050\120",string.byte(W))end)end local function y(W,l)local v=""for l=1,l,1 do local Z=W%256 v=string.char(Z)..v W=(W-Z)/256 end return v end local function J(W,l)local v=0 for l=l,l+3,1 do v=v*256+string.byte(W,l)end return v end local function c(W,l)local v=64-(l+9)%64 l=y(8*l,8)W=W..("\128"..(string.rep("\000",v)..l))assert(#W%64==0)return W end local function P(W)W[1]=1779033703 W[2]=3144134277 W[3]=1013904242 W[4]=2773480762 W[5]=1359893119 W[6]=2600822924 W[7]=528734635 W[8]=1541459225 return W end local function h(W,l,v)local Z={}for v=1,16,1 do Z[v]=J(W,l+(v-1)*4)end for W=17,64,1 do local l=Z[W-15]local v=K(b(l,7),b(l,18),F(l,3))l=Z[W-2]Z[W]=((Z[W-16]+v)+Z[W-7])+K(b(l,17),b(l,19),F(l,10))end local u,k,Q,A,j,a,H,y=v[1],v[2],v[3],v[4],v[5],v[6],v[7],v[8]for W=1,64,1 do local l=K(b(u,2),b(u,13),b(u,22))local v=K(o(u,k),o(u,Q),o(k,Q))local F=l+v local J=K(b(j,6),b(j,11),b(j,25))local c=K(o(j,a),o(s(j),H))local P=(((y+J)+c)+C[W])+Z[W]y,H,a,j,A,Q,k,u=H,a,j,A+P,Q,k,u,P+F end v[1]=o(v[1]+u)v[2]=o(v[2]+k)v[3]=o(v[3]+Q)v[4]=o(v[4]+A)v[5]=o(v[5]+j)v[6]=o(v[6]+a)v[7]=o(v[7]+H)v[8]=o(v[8]+y)end local function d(W)W=c(W,#W)local l=P({})for v=1,#W,64 do h(W,v,l)end return H(y(l[1],4)..(y(l[2],4)..(y(l[3],4)..(y(l[4],4)..(y(l[5],4)..(y(l[6],4)..(y(l[7],4)..y(l[8],4))))))))end return d; end
local sha256 = s256()
local alib = aeslib()
local curtex = ""
local niko = screen:CreateElement("Frame", {
    BackgroundColor3 = Color3.fromRGB(56, 56, 56),
    Size = UDim2.new(1, 0, 1, 0)
})
local nik1 = screen:CreateElement("TextButton", {
    Font = Enum.Font.Nunito,
    Text = "Log in",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextScaled = true,
    BackgroundColor3 = Color3.fromRGB(23, 170, 45),
    Size = UDim2.new(0.5, 0, 0.1, 0),
    Position = UDim2.new(0.25, 0, 0.5, 0)
})
local nik2 = screen:CreateElement("TextLabel", {
    Position = UDim2.new(0.25, 0, 0.2, 0),
    Size = UDim2.new(0.5, 0, 0.3, 0),
    TextColor3 = Color3.fromRGB(195, 195, 195),
    TextScaled = true,
    Font = Enum.Font.Roboto,
    BackgroundColor3 = Color3.fromRGB(63, 63, 63),
    Text = "Password",
})
niko:AddChild(nik1)
niko:AddChild(nik2)
local newvar
keyboard.TextInputted:Connect(function(tex) 
    curtex = tex
    if nik2 then
        nik2.Text = curtex
    end
    if newvar then
        newvar.Text = curtex
    end
end)
local ready
nik1.MouseButton1Click:Connect(function()
    disk:Write('spass',nik2.Text)
    ready = true
    screen:ClearElements()
end)
repeat 
    task.wait(1)
until ready
local hyperdrive = GetPartFromPort(1, "Hyperdrive")
local telescope = GetPartFromPort(1, "Telescope")
local sessionpass = disk:Read('spass'); disk:Write('spass','humancentipede')
local coordstore 
if disk:Read('e2eshenanigansda') then
    coordstore = JSONDecode(string.char(unpack(alib.decrypt_CTR(sha256(sessionpass),JSONDecode(disk:Read('e2eshenanigansda'))))))
else
    coordstore = {}
end
screen:ClearElements()
local elements = {}
elements["mainFrame"] = screen:CreateElement("Frame", { Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(56,56,56) })
elements["coordAction"] = screen:CreateElement("Frame", { Size = UDim2.new(1,0,0.1,0), Position = UDim2.new(0,0,0.9,0), BackgroundColor3 = Color3.fromRGB(255, 255, 255) }) elements.mainFrame:AddChild(elements.coordList)
elements["coordActionBox"] = screen:CreateElement("TextLabel", { Size = UDim2.new(0.8,0,1,0), Position = UDim2.new(0.2,0,0,0), TextScaled = true, FontFace = Font.new(Font.fromEnum(Enum.Font.Nunito.Family), Enum.FontWeight.SemiBold, Enum.FontStyle.Normal), PlaceholderColor3 = Color3.fromRGB(255,255,255), Text = "Coordinates", TextColor3 = Color3.fromRGB(255,255,255) }) elements.coordAction:AddChild(elements.coordActionBox) newvar = elements.coordActionBox
if hyperdrive then
    elements["coordActionLoad"] = screen:CreateElement("TextButton", { Position = UDim2.new(0.1,0,0,0), Size = UDim2.new(0.1,0,1,0), Font = Enum.Font.Ubuntu, Text = "Load From Hyperdrive", TextColor3 = Color3.fromRGB(255,255,255), TextScaled = true, BackgroundColor3 = Color3.fromRGB(33, 81, 255) }) elements.coordAction:AddChild(elements.coordActionLoad)
    elements["coordActionSave"] = screen:CreateElement("TextButton", { Position = UDim2.new(0,0,0,0), Size = UDim2.new(0.1,0,1,0), Font = Enum.Font.Ubuntu, TextScaled = true, Text = "Save", TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(16, 255, 92) }) elements.coordAction:AddChild(elements.coordActionSave)
else
    elements["coordActionSave"] = screen:CreateElement("TextButton", { Position = UDim2.new(0,0,0,0), Size = UDim2.new(0.2,0,1,0), Font = Enum.Font.Ubuntu, TextScaled = true, Text = "Save", TextColor3 = Color3.fromRGB(255,255,255), BackgroundColor3 = Color3.fromRGB(16, 255, 92) }) elements.coordAction:AddChild(elements.coordActionSave)
end
elements["mainframeTitle"] = screen:CreateElement("TextLabel", { Position = UDim2.new(0,0,0,0), Size = UDim2.new(1,0,0.1,0), BackgroundColor3 = Color3.fromRGB(26,26,26), TextScaled = true, Font = Enum.Font.Oswald, Text = "Compec's Coordinate Manager", TextColor3 = Color3.fromRGB(214, 214, 214) }) elements.mainFrame:AddChild(elements.mainframeTitle)
elements["coordScroll"] = screen:CreateElement("ScrollingFrame", { BackgroundColor3 = Color3.fromRGB(255,255,255), BackgroundTransparency = 1, Position = UDim2.new(0,0,0.1,0), Size = UDim2.new(1,0,0.9,0), CanvasSize = UDim2.new(0,0,3.2,0) }) elements.mainFrame:AddChild(elements.coordScroll)
local function refresh()
    for k,v in ipairs(coordstore) do
        if elements["coordScrollX"..k] then
            elements["coordScrollX"..k]:Destroy()
        end
        if elements["coordScroll"..k] then
            elements["coordScroll"..k]:Destroy()
        end
        elements["coordScroll"..k] = screen:CreateElement("TextButton", {
            Position = UDim2.new(0,0,(0.1*k)-0.1,0),
            Size = UDim2.new(1,0,0.04,0),
            BackgroundTransparency = true,
            TextColor3 = Color3.fromRGB(255,255,255),
            TextScaled = true,
            Font = Enum.Font.PressStart2P,
            Text = v
        }) elements.coordScroll:AddChild(elements["coordScroll"..k])
        elements["coordScrollX"..k] = screen:CreateElement("TextButton", {
            Position = UDim2.new(0.9,0,0,0),
            Size = UDim2.new(0.1,0,1,0),
            Text = "X",
            BackgroundTransparency = 1,
            Font = Enum.Font.Nunito,
            TextColor3 = Color3.fromRGB(255,0,0),
            TextScaled = true
        }) elements["coordScroll"..k]:AddChild(elements["coordScrollX"..k])
        elements["coordScroll"..k].MouseButton1Click:Connect(function()
            local curkey = ""..k
            if hyperdrive then
                hyperdrive:Configure({ Coordinates = coordstore[curkey] })
            end
            if telescope then
                telescope:Configure({ ViewCoordinates = coordstore[curkey] })
            end
        end)
        elements["coordScrollX"..k].MouseButton1Click:Connect(function()
            local curkey = ""..k
            elements["coordScrollX"..k]:Destroy()
            elements["coordScroll"..k]:Destroy()
            table.remove(coordstore,k)
        end)
    end
    disk:Write('e2eshenanigansda',JSONEncode(alib.encrypt_CTR(sha256(sessionpass),JSONEncode(coordstore))))
end
if elements.coordActionLoad then
    elements.coordActionLoad.MouseButton1Click:Connect(function()
        if string.sub(hyperdrive.Coordinates, -1, -4) == "true" then
            coordstore[#coordstore+1] = string.sub(hyperdrive.Coordinates,1,-6)
        else
            coordstore[#coordstore+1] = string.sub(hyperdrive.Coordinates,1,-7)
        end
        refresh()
    end)
end
elements.coordActionSave.MouseButton1Click:Connect(function()
    coordstore[#coordstore+1] = elements.coordActionBox.Text
    refresh()
end)