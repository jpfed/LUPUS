require("unittest")
require("random")

average = function(tbl)
  local total = 0
  for k, v in ipairs(tbl) do
    total = total + v
  end
  return total / #tbl
end

UnitTest("Random", {

  Ordering = function()
    local tbl = {1,2,3,4,5}
    Random.ordering(tbl)
  end,
  
  OrderingEmpty = function()
    local tbl = {}
    Random.ordering(tbl)
  end,
  
  OrderingIsLikelyRandom = function()
    local total = 0
    local tbl = {}
    for k=1,1024 do
      tbl[k] = k
    end
    Random.ordering(tbl)
    for k=1,1024 do
      if tbl[k] == k then total = total + 1 end
    end
    
    local mean = 1
    local sd = math.sqrt(2)
    assert(math.abs(total-mean)/sd < 4)
  end,
  
  Bernoulli = function()
    local n = 1024
    local p = math.random()
    local observations = {}
    for k = 1, n do
      local ob = 0
      if Random.bernoulli(p) then ob = 1 end
      observations[k] = ob
    end
    
    local mean = p
    local sd = math.sqrt(p*(1-p))
    local observedMean = average(observations)
    assert(math.abs(observedMean-mean)/sd < 4)
  end,
  
  Geometric = function()
    local n = 1024
    local p = 1-math.random()
    local observations = {}
    for k = 1, n do
      observations[k] = Random.geometric(p)
    end
    
    local mean = 1/p
    local sd = math.sqrt((1-p)/(p*p))
    local observedMean = average(observations)
    assert(math.abs(observedMean-mean)/sd < 4)
  end,
  
  Exponential = function()
    local n = 1024
    local r = 1-math.random()
    local observations = {}
    for k = 1, n do
      observations[k] = Random.exponential(r)
    end
    
    local mean = 1/r
    local sd = math.sqrt(1/(r*r))
    local observedMean = average(observations)
    assert(math.abs(observedMean-mean)/sd < 4)
  end,
  
  Normal = function()
    local n = 1024
    local m = 10+10*math.random()
    local s = 10+10*math.random()
    local observations = {}
    for k = 1, n do
      observations[k] = Random.normal(m,s)
    end
    
    local mean = m
    local sd = s
    local observedMean = average(observations)
    assert(math.abs(observedMean-mean)/sd < 4)  
  end,
  
  Poisson = function()
    local n = 1024
    local r = 1-math.random()
    local observations = {}
    for k = 1, n do
      observations[k] = Random.poisson(r)
    end
    
    local mean = r
    local sd = math.sqrt(r)
    local observedMean = average(observations)
    assert(math.abs(observedMean-mean)/sd < 4)
  end,
  
  Binomial = function()
    local n = 32
    local p = math.random()
    local nn = math.floor(10+30*math.random())
    local observations = {}
    for k = 1, n do
      observations[k] = Random.binomial(nn,p)
    end
    
    local mean = nn*p
    local sd = math.sqrt(nn*p*(1-p))
    local observedMean = average(observations)
    assert(math.abs(observedMean-mean)/sd < 4)  
  end,
}, verboseOutput)
