local ok=require("test").ok 

local lib=require "lib"

ok { interpolate = function ()
  assert(lib.interpolate(0, {1,2,4}, {10,20,40}) == 10) 
  assert(lib.interpolate(8, {1,2,4}, {10,20,40}) == 40) 
  assert(lib.interpolate(3, {1,2,4}, {10,20,40}) == 30) 
end}

ok { shuffle = function()
  local t= {}
  lib.rseed(1)
  for i = 1,9  do t[i] = i end
  for _ = 1,10 do print( lib.join( lib.shuffle(t), "") )  end 
end}

ok {sub= function()
  assert(lib.sub("timm")     == "timm")
  assert(lib.sub("timm",2)   == "imm")
  assert(lib.sub("timm",2,3) == "im")
  assert(lib.sub("timm",-1)  == "m")
  assert(lib.sub("aa",3,10)  == "")
end}

ok {minmax= function()
  assert(lib.min(2,3) == 2)
  assert(lib.max(2,3) == 3)
end}

ok { deepcopy = function()
  local b4 = {a={b={c={d=1},k=20}}, m=50}
  local now=lib.copy(b4)
  b4.a.b.c.d =10
  assert( b4.a.b.c.d ~= now.a.b.c.d )
end }

ok { cols = function()
     local t={ {"name", "age", "shoesize"},
               {"tim Menzies", 20, 40},
	       {"jane", 2.312211, 20 } }
     lib.cols(t, "%20.2f")
end}


