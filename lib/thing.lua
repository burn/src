require("burn")
local lib=require("lib")
local Object=require("object")

local Thing=Object:new{pos,txt,w=1,n=0}

function Thing:incs(t, f)
  f = f or function (z) return z end
  for _,v in pairs(t) do self:inc( f(v) ) end 
  return self
end

function Thing:inc(x)
  if x==Burn.ignore then return x end
  self.n = self.n + 1
  return self:inc1(x) 
end

function Thing:prep(x) return x end

function Thing:dec(x)
  if x==Burn.ignore then return x end
  if self.n < 3    then return x end
  self.n = self.n - 1
  return self:dec1(x) 
end

function Thing:simpler(i,j) 
  local  n = self.n
  return self.doubt() > Burn.ish*(i.doubt()*i.n/n + 
                                 j.doubt()*j.n/n) 
end

function Thing:norm(x) return x end

-- ### Thing:best(rows [, o]): function
-- Returns a function that returns true if a row selects for best ranges.
-- o = {x,y,enough=10,min=false}
-- - assumes `y(row)` returns a positive number 0..1
function Thing:best(rows, enough, x, y, min)
  enough = enough or 10
  min    = min or false
  x      = x or function (r) 
	         local val = r.cells[self.pos] 
	         return val=="?" and -10^32 or val end
  klass  = y or function (r) return r.cells[#r.cells] end
  y      = function(r) return min and 1-klass(r) or klass(r) end
  return self:best1(rows, enough, x,y) 
end

return Thing
