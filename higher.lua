map = function(tbl, op)
  local result = setmetatable({},getmetatable(tbl))
  for k, v in ipairs(tbl) do
    result[k] = op(v)
  end
  return result
end

zipWith = function(tbl1, tbl2, binOp)
  local result = setmetatable({}, getmetatable(tbl1))
  for k, v in ipairs(tbl1) do
    result[k] = binOp(tbl1[k], tbl2[k])
  end
  return result
end

apply = function(tbl, op)
  for k,v in ipairs(tbl) do
    tbl[k] = op(v)
  end
  return tbl
end

filter = function(tbl, criterion)
  local result = setmetatable({},getmetatable(tbl))
  for k, v in ipairs(tbl) do
    if criterion(v) then table.insert(result,v) end
  end
  return result
end

fold = function(tbl, seed, aggregator)
  local result = seed
  for k, v in ipairs(tbl) do
    result = aggregator(result, v)
  end
  return result
end

mapFold = function(tbl, op, seed, aggregator)
  local result = seed
  for k, v in ipairs(tbl) do
    result = aggregator(result, op(v))
  end
  return result
end

zipWithFold = function(tbl1, tbl2, op, seed, aggregator)
  local result = seed
  for k, v in ipairs(tbl1) do
    result = aggregator(result, op(v,tbl2[k]))
  end
  return result
end
