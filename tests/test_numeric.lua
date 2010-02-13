require("unittest")
require("numeric")

UnitTest("Numeric", {

  Interpolate = {
    Interpolate = function()
      assert(Num.interpolate(0,16,0.25,false) == 4)
    end,

    InterpolateEased = function()
      assert(Num.interpolate(0,16,0.25,true) < 4)
    end,
    
    InterpolateMidPoint = function()
      assert(Num.interpolate(0,16,0.5, false) == 8)
    end,
    
    InterpolateEasedMidpoint = function()
      assert(Num.interpolate(0,16,0.5, true) == 8)
    end,
  },
  
  Limit = {
    Limit = function()
      assert(Num.limit(0.5,0,1) == 0.5)
    end,
    
    LimitFloor = function()
      assert(Num.limit(-0.5,0,1) == 0)
    end,
    
    LimitCeiling = function()
      assert(Num.limit(1.5, 0,1) == 1)
    end,
  },
  
  Remap = {
    Remap = function()
      assert(Num.remap(1.5,1,2,10,50) == 30)
    end,
    
    RemapLowerLimit = function()
      assert(Num.remap(1,1,2,10,50) == 10)
    end,
    
    RemapUpperLimit = function()
      assert(Num.remap(2,1,2,10,50) == 50)
    end,
    
    RemapOutsideLowerLimit = function()
      assert(Num.remap(-1,1,2,10,50) == -70)
    end,
    
    RemapOutsideUpperLimit = function()
      assert(Num.remap(3,1,2,10,50) == 90)
    end,
  }
}, verboseOutput)
