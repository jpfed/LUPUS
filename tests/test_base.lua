require("unittest")
require("base")

UnitTest("Base", {

  Creation = {
    TestCreateBase = function()
      local b = Base:create()
    end,
    
    TestCreateBaseComplex = function()
      local payload = {present = true}
      local b2 = Base:create(payload)
      assert(b2.present)
    end,
  },
  
  Mixins = {
    TestMixinBase = function()
      local tomixin = {a = "a", b = "b"}
      local b3 = Base:create()
      b3:mixin(tomixin)
      assert(b3.a == "a")
      assert(b3.b == "b")
    end,
    
    TestIsABase = function()
      local SomeClass = {blah = true, floop = 1}
      local OtherClass = {blah = true, floop = 2}
      local myInstance = Base:create(SomeClass)
      assert(myInstance:isA(Base))
      assert(myInstance:isA(SomeClass))
      assert(not myInstance:isA(OtherClass))
    end,
  },
  
  Misc = {
    TestToString = function()
      local complex = {triquery = {deeply = {nested = {}},}, one = 1, two = "two"}
      local instance = Base:create(complex)
      local str = instance:toString()
      assert(str:find("one: 1"))
      assert(str:find("two: two"))
    end,
    
    TestCopy = function()
      local included = {one = "one", fun = function() print("woohoo!") end}
      local original = Base:create(included)
      local copy = original:copy()
      assert(original ~= copy)
      assert(original.one == copy.one)
      assert(original.fun == copy.fun)  
    end,
  }
}, verboseOutput)
