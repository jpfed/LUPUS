if verboseOutput == nil then verboseOutput = false end

UnitTest = function(name, toTest, verbose, indent)
  local failures = {}
  if indent == nil then indent = 0 end
  local indentString = string.rep("  ",indent)
  if type(toTest) == "function" then
    local noErrors, errorMessage = pcall(toTest)
    if noErrors then
      if verbose then print(indentString .. name) end
    else
      if verbose then print(indentString .. name .. " **ERROR**:" .. errorMessage) end
      return {name}
    end
  elseif type(toTest) == "table" then
    if verbose then print(indentString .. name) end
    for k, v in pairs(toTest) do
      local newFailures = UnitTest(k,v, verbose, indent+1)
      for fk, fv in pairs(newFailures) do
        table.insert(failures, fv)
      end
    end
  end
  if indent == 0 then
    if #failures > 0 then
      local prefix = ""
      if verbose then
        print()
        print("FAILURES: " .. #failures)
        prefix = "  "
      end
      for k, v in pairs(failures) do
        print(prefix .. v)
      end
    else
      if verbose then
        print()
        print("HELLS YEAH! ALL TESTS PASS! WOOHOO!")
      end
    end
    if verbose then
      print()
      print()
    end
  end
  return failures
end

withinTolerance = function(a,b,message)
  if message == nil then message = tostring(a) .. " and " .. tostring(b) .. " are not within tolerance." end
  assert(math.abs(a-b) < 0.00001, message)
end
