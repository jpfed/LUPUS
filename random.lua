-- translated from wikipedia and Numerical Recipes In C
Random = {
  
  ordering = function(tbl)
    for k=#tbl,1,-1 do
      local swapIndex = math.random(k)
      tbl[k],tbl[swapIndex] = tbl[swapIndex], tbl[k]
    end
  end,

  bernoulli = function(p)
    return math.random() < p
  end,
  
  geometric = function(p)
    return math.ceil(math.log(1-math.random())/math.log(1-p))
  end,
  
  exponential = function(rate)
    return -math.log(1-math.random())/rate
  end,
  
  normal = function(mean, stdev)
    local u, v = 1-math.random(), 1-math.random()
    return math.sqrt(-2*math.log(u))*math.cos(2*math.pi*v)*stdev + mean
  end,
  
  poisson = function(mean)
    assert(mean >= 0, "Negative value for mean: " .. tostring(lambda) .. " in Random.poisson.")
    if mean < 12 then
      if Random.poisson_mean ~= mean then
        Random.poisson_mean = mean
        Random.poisson_g = math.exp(-mean)
      end
      local g = Random.poisson_g
      local em, t = -1, 1
      while true do
        em = em + 1
        t = t * math.random()
        if t < g then return em end
      end
    else
      if Random.poisson_mean ~= mean then
        Random.poisson_mean = mean
        Random.poisson_sq = math.sqrt(2*mean)
        Random.poisson_ln_mean = math.log(mean)
        Random.poisson_g = mean * Random.poisson_ln_mean - Random._ln_gamma(mean + 1.0)
      end
      local sq = Random.poisson_sq
      local ln_mean = Random.poisson_ln_mean
      local g = Random.poisson_g
      local y
      local em = -1
      while true do
        while em < 0 do
          y = math.tan(math.pi*math.random())
          em = sq*y+mean
        end
        local t = 0.9*(1+y*y)*math.exp(em*ln_mean-Random._ln_gamma(em+1)-g)
        if t >= math.random() then return em end
      end
    end
  end,
  
  binomial = function(n, pp)
    assert(0 <= pp and pp <= 1, "Invalid trial probability: " .. tostring(pp) .. " in Random.binomial.")
    
    local result = 0
    
    local p = pp
    if pp > 0.5 then p = 1 - pp end
    
    local mean = n*p
    if n < 25 then -- small problem, use direct method
      for j=1,n do
        if math.random() < p then result = result + 1 end
      end
    elseif mean < 1.0 then -- use Poisson approximation
      local g = math.exp(-mean)
      local t = 1
      local j = 0
      while j <= n do
        t = t * math.random()
        if t < g then break end
        j = j + 1
      end
      result = math.min(j,n)
    else -- use rejection method
      if Random.binomial_n ~= n then
        Random.binomial_n = n
        Random.binomial_g = Random._ln_gamma(Random.binomial_n + 1)
      end
      local en = Random.binomial_n
      local g = Random.binomial_g
      
      if Random.binomial_p ~= p then
        Random.binomial_pc = 1-p
        Random.binomial_lnp = math.log(p)
        Random.binomial_lnpc = math.log(Random.binomial_pc)
        Random.binomial_p = p
      end
      local pc = Random.binomial_pc
      local lnp = Random.binomial_lnp
      local lnpc = Random.binomial_lnpc
      local sq = math.sqrt(2*mean*pc)
      
      
      local r, em, y = math.huge, -1, nil
      repeat
        while em < 0 or em >= en + 1 do
          y = math.tan(math.pi*math.random())
          em = sq*y*mean
        end
        em = math.floor(em)
        t = 1.2*sq*(1+y*y)*math.exp(g-Random._ln_gamma(em+1)-Random._ln_gamma(en-em+1)+em*lnp+(en-em)*lnpc)
        r = math.random()
      until r <= t
      result = em
    end
    if p ~= pp then result = n - result end
    return result
  end,
  
  _ln_gamma = function(xx)
    local cof = {
      76.18009172947146,
      -86.50532032941677,
      24.01409824083091,
      -1.231739572450155,
      0.001208650973866179,
      -0.000005395239384953
    }
    local x, y = xx, xx
    local tmp = x + 5.5
    tmp = tmp - (x+0.5)*math.log(tmp)
    local ser = 1.000000000190015
    for j=1,6 do
      y = y+1
      ser = ser + cof[j]/y
    end
    return -tmp+math.log(2.5066282746310005*ser/x)
  end,
}
