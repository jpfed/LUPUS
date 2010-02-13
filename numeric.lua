Num = {

  interpolate = function(x1,x2,weight,eased)
    local cweight
    if eased then
      local weight2 = weight*weight
      weight = 3*weight2 - 2*weight2*weight
    end
    cweight = 1-weight
    return x1*cweight + x2*weight
  end,

  limit = function(value, lowerLimit, upperLimit)
    return math.min(upperLimit, math.max(lowerLimit, value))
  end,

  remap = function(value, lowerLimitOld, upperLimitOld, lowerLimitNew, upperLimitNew)
    local rangeOld = upperLimitOld - lowerLimitOld
    local rangeNew = upperLimitNew - lowerLimitNew
    local scale = rangeNew/rangeOld
    
    return (value - lowerLimitOld)*scale + lowerLimitNew
  end,
  
}