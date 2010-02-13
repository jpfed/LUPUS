require("unittest")
require("higher")

UnitTest("Higher-order functions", {

  Map = function()
    local a = {4,7,6,1,8}
    local b = map(a, function(x) return x >= 5 end)
    assert(b[2] and b[3] and b[5])
    assert(not (b[1] or b[4]))
  end,

  MapEmpty = function()
    local a = {}
    local b = map(a, function(x) return x >= 5 end)
    assert(#b == 0)
  end,
  
  ZipWith = function()
    local a = {4,7,6,1,8}
    local b = {2,3,2,3,2}
    local c = zipWith(a,b, function(x,y) return x+y end)
    assert(c[1] == 6)
    assert(c[2] == 10)
    assert(c[3] == 8)
    assert(c[4] == 4)
    assert(c[5] == 10)
  end,

  ZipWithEmpty = function()
    local a = {}
    local b = {}
    local c = zipWith(a,b, function(x,y) return x+y end)
    assert(#c == 0)
  end,
  
  Apply = function()
    local a = {4,7,6,1,8}
    apply(a, function(x) return x >= 5 end)
    assert(a[2] and a[3] and a[5])
    assert(not (a[1] or a[4]))    
  end,

  ApplyEmpty = function()
    local a = {}
    apply(a, function(x) return x >= 5 end)
    assert(#a == 0)
  end,
  
  Filter = function()
    local a = {4,7,6,1,8}
    local b = filter(a, function(x) return x >= 5 end)
    assert(#b == 3)
    assert(b[1] == 7)
    assert(b[2] == 6)
    assert(b[3] == 8)
  end,

  FilterEmpty = function()
    local a = {}
    local b = filter(a, function(x) return x >= 5 end)
    assert(#b == 0)
  end,
  
  FilterEmptyResult = function()
    local a = {4,7,6,1,8}
    local b = filter(a, function(x) return x >= 50 end)
    assert(#b == 0)
  end,
  
  Fold = function()
    local a = {4,7,6,1,8}
    local sum = fold(a, 0, function(running, current) return running + current end )
    assert(sum == 4 + 7 + 6 + 1 + 8)
  end,

  FoldEmpty = function()
    local a = {}
    local sum = fold(a, 0, function(running, current) return running + current end )
    assert(sum == 0)
  end,
  
  MapFold = function()
    local a = {4,7,6,1,8}
    local b = mapFold(a, function(x) return x + 2 end, 0, function(y,z) return y + z end)
    assert(b == 4+7+6+1+8+10)
  end,
  
  MapFoldEmpty = function()
    local a = {}
    local b = mapFold(a, function(x) return x + 2 end, 0, function(y,z) return y + z end)
    assert(b == 0)  
  end,
  
  ZipWithFold = function()
    local a = {true, false, true, false}
    local b = {true, false, false, true}
    local c = zipWithFold(a,b, function(j,k) return j == k end, 0, function(x,y) if y then return x+1 else return x end end)
    assert(c == 2,c)
  end,
  
  ZipWithFoldEmpty = function()
    local a = {}
    local b = {}
    local c = zipWithFold(a,b, function(j,k) return j == k end, 0, function(x,y) if y then return x+1 else return x end end)
    assert(c == 0) 
  end
}, verboseOutput)
