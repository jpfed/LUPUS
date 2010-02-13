require("unittest")
require("vector")

UnitTest("Vector", {

  Vector = {
    Create = function()
      local v = Vector:create({1,1,2})
    end,
    
    Add = function()
      local v1 = Vector:create({1,2,3})
      local v2 = Vector:create({4,6,8})
      local v3 = v1+v2
      assert(v3[1] == 5)
      assert(v3[2] == 8)
      assert(v3[3] == 11)
    end,
    
    Subtract = function()
      local v1 = Vector:create({1,2,3})
      local v2 = Vector:create({4,6,8})
      local v3 = v1-v2
      assert(v3[1] == -3)
      assert(v3[2] == -4)
      assert(v3[3] == -5)    
    end,
    
    DotProduct = function()
      local v1 = Vector:create({1,2,3})
      local v2 = Vector:create({4,6,8})
      local s = v1*v2
      assert(s == 4+12+24)   
    end,
    
    ScaleByConstant = function()
      local v1 = Vector:create({1,2,3})
      local v2 = v1*3
      assert(v2[1] == 3)
      assert(v2[2] == 6)
      assert(v2[3] == 9)
    end,
    
    UnaryMinus = function()
      local v1 = Vector:create({1,2,3})
      local v2 = -v1
      assert(v2[1] == -1)
      assert(v2[2] == -2)
      assert(v2[3] == -3)    
    end,
    
    Equals = function()
      local v1 = Vector:create({1,2,3})
      local v2 = Vector:create({1,2,3})
      assert(v1 == v2)
    end,
    
    Length = function()
      local v = Vector:create({3,4,12})
      assert(v:length() == 13)
    end,
    
    Maximum = function()
      local v = Vector:create({3,4,12})
      assert(v:maximum() == 12)    
    end,
    
    Minimum = function()
      local v = Vector:create({3,4,12})
      assert(v:minimum() == 3)    
    end,
    
    Normalize = function()
      local v1 = Vector:create({3,4,12})
      local v2 = v1:normalize()
      assert(v2[1] == 3/13)
      assert(v2[2] == 4/13)
      assert(v2[3] == 12/13)
    end,
    
    NormalizeInf = function()
      local v1 = Vector:create({3,4,12})
      local v2 = v1:normalizeInf()
      assert(v2[1] == 3/12)
      assert(v2[2] == 4/12)
      assert(v2[3] == 12/12)   
    end,
    
    ChainedOperations = function()
      local s = (Vector:create({1,2,3}) + Vector:create({2,2,9})):normalize() * Vector:create({0,0,13/12})
      assert (s == 1)
    end,

    AngleWith = {
      AngleWithCoincident = function()
        local v1 = Vector:create({1,0,0})
        local v2 = Vector:create({1,0,0})
        assert(v1:angleWith(v2) == 0)
      end,    
      
      AngleWithOpposite = function()
        local v1 = Vector:create({1,0,0})
        local v2 = Vector:create({-1,0,0})
        assert(v1:angleWith(v2) == math.pi)
      end,    
      
      AngleWithPerpendicular = function()
        local v1 = Vector:create({1,0,0})
        local v2 = Vector:create({0,0,1})
        assert(v1:angleWith(v2) == math.pi/2)
      end,    
      
      AngleWith45 = function()
        local v1 = Vector:create({1,0,0})
        local v2 = Vector:create({1,0,1})
        withinTolerance(v1:angleWith(v2), math.pi/4)
      end,
      
      AngleWithDegenerate = function()
        local v1 = Vector:create({1,0,0})
        local v2 = Vector:create({0,0,0})
        withinTolerance(v1:angleWith(v2), 0)
      end,
    },
    
    AlignmentWith = {
      AlignmentWithCoincident = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({3,0,0})
        assert(v1:alignmentWith(v2) == 1)
      end,
      
      AlignmentWithOpposite = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({-3,0,0})
        assert(v1:alignmentWith(v2) == -1)
      end,

      AlignmentWithPerpendicular = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({0,0,3})
        assert(v1:alignmentWith(v2) == 0)
      end,    
      
      AlignmentWith45 = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({3,0,3})
        assert(v1:alignmentWith(v2) == math.sqrt(2)/2)
      end,
      
      AlignmentWithDegenerate = function()
        local v1 = Vector:create({1,0,0})
        local v2 = Vector:create({0,0,0})
        withinTolerance(v1:alignmentWith(v2), 0)
      end,      
    },
    
    ProjectOnto = {
      ProjectOntoCoincident = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({3,0,0})
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 2)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,
      
      ProjectOntoOpposite = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({-3,0,0})
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 2)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,

      ProjectOntoPerpendicular = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({0,0,3})
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 0)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,    
      
      ProjectOnto45 = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({3,0,3})
        local v3 = v1:projectOnto(v2)
        withinTolerance(v3[1], 1)
        assert(v3[2] == 0)
        withinTolerance(v3[3], 1)
      end,
      
      ProjectOntoDegenerate = function()
        local v1 = Vector:create({2,0,0})
        local v2 = Vector:create({0,0,0})
        local v3 = v1:projectOnto(v2)
        withinTolerance(v3[1], 0)
        withinTolerance(v3[2], 0)
        withinTolerance(v3[3], 0)
      end,      
    },
  },
  
  V2 = {
    Create = function()
      local v = V2:create(3,4)
    end,
    
    Add = function()
      local v1 = V2:create(3,4)
      local v2 = V2:create(5,9)
      local v3 = v1+v2
      assert(v3[1] == 8)
      assert(v3[2] == 13)
    end,
    
    Subtract = function()
      local v1 = V2:create(3,4)
      local v2 = V2:create(5,9)
      local v3 = v1-v2
      assert(v3[1] == -2)
      assert(v3[2] == -5)    
    end,
    
    DotProduct = function()
      local v1 = V2:create(3,4)
      local v2 = V2:create(5,9)
      local s = v1*v2
      assert(s == 3*5 + 4*9)   
    end,
    
    ScaleByConstant = function()
      local v1 = V2:create(1,2)
      local v2 = v1*3
      assert(v2[1] == 3)
      assert(v2[2] == 6)
    end,
    
    UnaryMinus = function()
      local v1 = V2:create(3,4)
      local v2 = -v1
      assert(v2[1] == -3)
      assert(v2[2] == -4)
    end,
    
    Equals = function()
      local v1 = V2:create(3,4)
      local v2 = V2:create(3,4)
      assert(v1 == v2)
    end,
    
    Length = function()
      local v1 = V2:create(3,4)
      assert(v1:length() == 5)
    end,

    Normalize = function()
      local v1 = V2:create(3,4)
      local v2 = v1:normalize()
      withinTolerance(v2[1], 3/5)
      withinTolerance(v2[2], 4/5)
    end, 
    
    CrossProductZero = function()
      local v1 = V2:create(3,4)
      local v2 = v1*2
      assert(v1:cross(v2) == 0) 
    end,   
    
    CrossProductOne = function()
      local v1 = V2:create(1,0)
      local v2 = V2:create(0,1)
      assert(v1:cross(v2) == 1)
    end,

    AngleWith = {
      AngleWithCoincident = function()
        local v1 = V2:create(1,0)
        local v2 = V2:create(1,0)
        assert(v1:angleWith(v2) == 0)
      end,    
      
      AngleWithOpposite = function()
        local v1 = V2:create(1,0)
        local v2 = V2:create(-1,0)
        assert(v1:angleWith(v2) == math.pi)
      end,    
      
      AngleWithPerpendicular = function()
        local v1 = V2:create(1,0)
        local v2 = V2:create(0,1)
        assert(v1:angleWith(v2) == math.pi/2)
      end,    
      
      AngleWith45 = function()
        local v1 = V2:create(1,0)
        local v2 = V2:create(1,1)
        withinTolerance(v1:angleWith(v2), math.pi/4)
      end,

      AngleWithDegenerate = function()
        local v1 = V2:create(1,0)
        local v2 = V2:create(0,0)
        assert(v1:angleWith(v2) == 0)
      end,    
    },
    
    AlignmentWith = {
      AlignmentWithCoincident = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(3,0)
        assert(v1:alignmentWith(v2) == 1)
      end,
      
      AlignmentWithOpposite = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(-3,0)
        assert(v1:alignmentWith(v2) == -1)
      end,

      AlignmentWithPerpendicular = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(0,3)
        assert(v1:alignmentWith(v2) == 0)
      end,    
      
      AlignmentWith45 = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(3,3)
        assert(v1:alignmentWith(v2) == math.sqrt(2)/2)
      end,
      
      AlignmentWithDegenerate = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(0,0)
        assert(v1:alignmentWith(v2) == 0)
      end,      
    },
    
    ProjectOnto = {
      ProjectOntoCoincident = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(3,0)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 2)
        assert(v3[2] == 0)
      end,
      
      ProjectOntoOpposite = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(-3,0)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 2)
        assert(v3[2] == 0)
      end,

      ProjectOntoPerpendicular = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(0,3)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 0)
        assert(v3[2] == 0)
      end,    
      
      ProjectOnto45 = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(3,3)
        local v3 = v1:projectOnto(v2)
        withinTolerance(v3[1], 1)
        withinTolerance(v3[2], 1)
      end,
      
      ProjectOntoDegenerate = function()
        local v1 = V2:create(2,0)
        local v2 = V2:create(0,0)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 0)
        assert(v3[2] == 0)
      end,          
    },
  },
  
  V3 = {
    Create = function()
      local v = V3:create(1,1,2)
    end,
    
    Add = function()
      local v1 = V3:create(1,2,3)
      local v2 = V3:create(4,6,8)
      local v3 = v1+v2
      assert(v3[1] == 5)
      assert(v3[2] == 8)
      assert(v3[3] == 11)
    end,
    
    Subtract = function()
      local v1 = V3:create(1,2,3)
      local v2 = V3:create(4,6,8)
      local v3 = v1-v2
      assert(v3[1] == -3)
      assert(v3[2] == -4)
      assert(v3[3] == -5)    
    end,
    
    DotProduct = function()
      local v1 = V3:create(1,2,3)
      local v2 = V3:create(4,6,8)
      local s = v1*v2
      assert(s == 4+12+24)   
    end,

    ScaleByConstant = function()
      local v1 = V3:create(1,2,3)
      local v2 = v1*3
      assert(v2[1] == 3)
      assert(v2[2] == 6)
      assert(v2[3] == 9)
    end,
    
    UnaryMinus = function()
      local v1 = V3:create(1,2,3)
      local v2 = -v1
      assert(v2[1] == -1)
      assert(v2[2] == -2)
      assert(v2[3] == -3)    
    end,
    
    Equals = function()
      local v1 = V3:create(1,2,3)
      local v2 = V3:create(1,2,3)
      assert(v1 == v2)
    end,
    
    Length = function()
      local v = V3:create(3,4,12)
      assert(v:length() == 13)
    end,

    Normalize = function()
      local v1 = V3:create(3,4,12)
      local v2 = v1:normalize()
      assert(v2[1] == 3/13)
      assert(v2[2] == 4/13)
      assert(v2[3] == 12/13)
    end, 
    
    CrossProductOne = function()
      local v1 = V3:create(1,0,0)
      local v2 = V3:create(0,0,1)
      local v3 = v1:cross(v2)
      assert(v3[1] == 0)
      assert(v3[2] == -1)
      assert(v3[3] == 0)
    end,    
    
    CrossProductZero = function()
      local v1 = V3:create(3,4,12)
      local v2 = v1*3
      local cp = v1:cross(v2) 
      assert(cp[1] == 0)
      assert(cp[2] == 0)
      assert(cp[3] == 0)
    end,   

    AngleWith = {
      AngleWithCoincident = function()
        local v1 = V3:create(1,0,0)
        local v2 = V3:create(1,0,0)
        assert(v1:angleWith(v2) == 0)
      end,    
      
      AngleWithOpposite = function()
        local v1 = V3:create(1,0,0)
        local v2 = V3:create(-1,0,0)
        assert(v1:angleWith(v2) == math.pi)
      end,    
      
      AngleWithPerpendicular = function()
        local v1 = V3:create(1,0,0)
        local v2 = V3:create(0,0,1)
        assert(v1:angleWith(v2) == math.pi/2)
      end,    
      
      AngleWith45 = function()
        local v1 = V3:create(1,0,0)
        local v2 = V3:create(1,0,1)
        withinTolerance(v1:angleWith(v2), math.pi/4)
      end,

      AngleWithDegenerate = function()
        local v1 = V3:create(1,0,0)
        local v2 = V3:create(0,0,0)
        assert(v1:angleWith(v2) == 0)
      end,    
    },
    
    AlignmentWith = {
      AlignmentWithCoincident = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(3,0,0)
        assert(v1:alignmentWith(v2) == 1)
      end,
      
      AlignmentWithOpposite = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(-3,0,0)
        assert(v1:alignmentWith(v2) == -1)
      end,

      AlignmentWithPerpendicular = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(0,0,3)
        assert(v1:alignmentWith(v2) == 0)
      end,    
      
      AlignmentWith45 = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(3,0,3)
        assert(v1:alignmentWith(v2) == math.sqrt(2)/2)
      end,
      
      AlignmentWithDegenerate = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(0,0,0)
        assert(v1:alignmentWith(v2) == 0)
      end,      
    },
    
    ProjectOnto = {
      ProjectOntoCoincident = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(3,0,0)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 2)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,
      
      ProjectOntoOpposite = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(-3,0,0)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 2)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,

      ProjectOntoPerpendicular = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(0,0,3)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 0)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,    
      
      ProjectOnto45 = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(3,0,3)
        local v3 = v1:projectOnto(v2)
        withinTolerance(v3[1], 1)
        withinTolerance(v3[2], 0)
        withinTolerance(v3[3], 1)
      end,
      
      ProjectOntoDegenerate = function()
        local v1 = V3:create(2,0,0)
        local v2 = V3:create(0,0,0)
        local v3 = v1:projectOnto(v2)
        assert(v3[1] == 0)
        assert(v3[2] == 0)
        assert(v3[3] == 0)
      end,          
    },   
  },
}, verboseOutput)
