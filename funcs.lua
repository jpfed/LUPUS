Funcs = {
  
  add = function(x, y) return x + y end,
  
  subtract = function(x, y) return x - y end,
  
  multiply = function(x, y) return x * y end,
  
  divide = function(x, y) return x / y end,
  
  modulus = function(x, y) return x % y end,
  
  power = function(x, y) return x ^ y end,
  
  unaryMinus = function(x) return -x end,
  
  reciprocal = function(x) return 1/x end,
  
  square = function(x) return x*x end,
  
  equals = function(x, y) return x == y end,
  
  lessThan = function(x, y) return x < y end,
  
  lessThanOrEqual = function(x, y) return x <= y end,
  
  greaterThan = function(x, y) return x > y end,
  
  greaterThanOrEqual = function(x, y) return x >= y end,
  
  positive = function(x) return x > 0 end,
  
  nonnegative = function(x) return x >= 0 end,
  
  within = function(x) return (function(y,z) return math.abs(y-z) >= x end) end,
  
  ["or"] = function(x, y) return x or y end,
  
  ["and"] = function(x, y) return x and y end,
  
  xor = function(x, y) return (x or y) and not (x and y) end,

  ["not"] = function(x) return not x end

}