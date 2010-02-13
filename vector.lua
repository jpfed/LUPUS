require("higher")
require("funcs")

Vector = {
  create = function(self, vectorAsTable)
    return setmetatable(vectorAsTable, self)
  end,
  
  __add = function(a, b)
    return zipWith(a,b, Funcs.add)
  end,
  
  __sub = function(a, b)
    return zipWith(a,b, Funcs.subtract)
  end,
  
  __mul = function(a, b)
    if type(a) == "number" then
      return map(b,function(x) return a*x end)
    elseif type(b) == "number" then
      return map(a,function(x) return b*x end)   
    else
      return zipWithFold(a,b, Funcs.multiply, 0, Funcs.add)
    end
  end,
  
  __unm = function(a)
    return map(a, Funcs.unaryMinus)
  end,
  
  __eq = function(a, b)
    return zipWithFold(a,b, Funcs.equals, true, Funcs["and"])
  end,
  
  length = function(a)
    return math.sqrt(mapFold(a, Funcs.square, 0, Funcs.add))
  end,
  
  minimum = function(a)
    return fold(a, math.huge, math.min)
  end,
  
  maximum = function(a)
    return fold(a, -math.huge, math.max)
  end,
  
  normalize = function(a)
    return a*(1/a:length())
  end,
  
  normalizeInf = function(a)
    return a*(1/a:maximum())
  end,
  
  angleWith = function(a, b)
    return math.acos((a:normalize())*(b:normalize()))
  end,
  
  alignmentWith = function(a, b)
    return (a:normalize())*(b:normalize())
  end,
  
  projectOnto = function(a, b)
    local dir = b:normalize()
    return (a*dir)*dir
  end,
}

Vector.__index = Vector

-- there are some special characteristics of 2d vectors, so while we're 
-- at it we might as well do some loop-unrolling for performance (about 3x gain over Vector)
V2 = {
  create = function(self,v1,v2)
    return setmetatable({v1,v2},self)
  end,
 
 __add = function(a, b)
    return V2:create(a[1]+b[1], a[2]+b[2])
  end,
  
  __sub = function(a, b)
    return V2:create(a[1]-b[1], a[2]-b[2])
  end,
  
  __mul = function(a, b)
    if type(a) == "number" then
      return V2:create(a*b[1], a*b[2])
    elseif type(b) == "number" then
      return V2:create(a[1]*b, a[2]*b)
    else
      return a[1]*b[1] + a[2]*b[2]
    end
  end,
  
  __unm = function(a)
    return V2:create(-a[1],-a[2])
  end,
  
  __eq = function(a, b)
    return a[1] == b[1] and a[2] == b[2]
  end,
  
  cross = function(a,b)
    return a[1]*b[2] - a[2]*b[1]
  end,
  
  length = function(a)
    return math.sqrt(a[1]*a[1] + a[2]*a[2])
  end,
  
  normalize = function(a)
    return a*(1/a:length())
  end,
  
  angleWith = function(a, b)
    return math.acos((a:normalize())*(b:normalize()))
  end,
  
  alignmentWith = function(a, b)
    return (a:normalize())*(b:normalize())
  end,
  
  projectOnto = function(a, b)
    local dir = b:normalize()
    return (a*dir)*dir
  end,
}

V2.__index = V2

-- there are some special characteristics of 3d vectors, so while we're 
-- at it we might as well do some loop-unrolling for performance (about 3x gain over Vector)
V3 = {
  create = function(self,v1,v2,v3)
    return setmetatable({v1,v2,v3},self)
  end,
  
  __add = function(a, b)
    return V3:create(a[1]+b[1], a[2]+b[2], a[3]+b[3])
  end,
  
  __sub = function(a, b)
    return V3:create(a[1]-b[1], a[2]-b[2], a[3]-b[3])
  end,
  
  __mul = function(a, b)
    if type(a) == "number" then
      return V3:create(a*b[1], a*b[2], a*b[3])
    elseif type(b) == "number" then
      return V3:create(a[1]*b, a[2]*b, a[3]*b)
    else
      return a[1]*b[1] + a[2]*b[2] + a[3]*b[3]
    end
  end,
  
  __unm = function(a)
    return V3:create(-a[1],-a[2],-a[3])
  end,
  
  __eq = function(a, b)
    return a[1] == b[1] and a[2] == b[2] and a[3] == b[3]
  end,
  
  cross = function(a,b)
    return V3:create(a[2]*b[3] - a[3]*b[2], a[3]*b[1] - a[1]*b[3], a[1]*b[2]-a[2]*b[1])
  end,
  
  length = function(a)
    return math.sqrt(a[1]*a[1] + a[2]*a[2] + a[3]*a[3])
  end,
  
  normalize = function(a)
    return a*(1/a:length())
  end,
  
  angleWith = function(a, b)
    return math.acos((a:normalize())*(b:normalize()))
  end,
  
  alignmentWith = function(a, b)
    return (a:normalize())*(b:normalize())
  end,
  
  projectOnto = function(a, b)
    local dir = b:normalize()
    return (a*dir)*dir
  end,
}

V3.__index = V3