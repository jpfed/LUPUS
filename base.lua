Base = {
  create = function(b,opts)
    return Base.mixin({},b):mixin(opts)
  end,

  mixin = function(destination, source)
    if source == nil then return destination end
    for k,v in pairs(source) do
      if k ~= "_mixed_in" then destination[k] = v end
    end
    if destination._mixed_in == nil then destination._mixed_in = {} end
    destination._mixed_in[source] = true
    if source._mixed_in ~= nil then
      for k,v in pairs(source._mixed_in) do
        destination._mixed_in[k] = true
      end
    end
    -- allow chaining for less verbose constructors
    return destination  
  end,
  
  isA = function(object, class)
    return object._mixed_in[class]
  end,

  toString = function(object, name)
    if name == nil then name = "" else name = name .. ": " end
    local result
    result = (name .. tostring(object) .. "\n")
    for k,v in pairs(object) do
      result = result .. (name .. tostring(k) .. ": " .. tostring(v) .. "\n")
    end
    return result
  end,
  
  copy = function(object)
    return Base.mixin({},object)
  end
}
