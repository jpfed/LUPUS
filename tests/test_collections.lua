require("unittest")
require("collections")


UnitTest("Collections", {

  Grid = {
    Create = function()
      local g = Grid:create()
    end,

    CreateWithDefaultValue = function()
      local g = Grid:create(nil, 1)
    end,
    
    Set = function()
      local g = Grid:create()
      g:set(1,1,{value = 1})
    end,
    
    SetAndGet = function()
      local g = Grid:create()
      g:set(2,4,"Blabbertyjabberty")
      assert(g:get(2,4) == "Blabbertyjabberty")
    end,

    SetAndGetWithDefaultValue = function()
      local g = Grid:create(nil, 1)
      assert(g:get(2,4) == 1)
      g:set(2,4,"Blabbertyjabberty")
      assert(g:get(2,4) == "Blabbertyjabberty")
    end,
    
    SetAndGetMultiple = function()
      local g = Grid:create()
      for x = 1,10 do
        for y = 1,10 do
          g:set(x,y,x*y)
        end
      end
      for x = 1,10 do
        for y = 1,10 do
          assert(g:get(x,y) == x*y)
        end
      end
    end,
    
    GetEmpty = function()
      local g = Grid:create()
      assert(g:get(1,1) == nil)
    end,
  
    GetLocationNotSet = function()
      local g = Grid:create()
      g:set(10,10,1)
      assert(g:get(1,1) == nil)
    end,
  
    BoundsStartNil = function()
      local g = Grid:create()
      assert(g.minX == nil)
      assert(g.minY == nil)
      assert(g.maxX == nil)
      assert(g.maxY == nil)
    end,
    
    BoundsCanBeLargerThanOne = function()
      local g = Grid:create()
      g:set(10,20,1)
      assert(g.minX == 10)
      assert(g.minY == 20)
      assert(g.maxX == 10)
      assert(g.maxY == 20)
      g:set(20,30,2)
      assert(g.minX == 10)
      assert(g.minY == 20)
      assert(g.maxX == 20)
      assert(g.maxY == 30)      
    end,
    
    BoundsCanBeNegative = function()
      local g = Grid:create()
      g:set(-10,-20,1)
      assert(g.minX == -10)
      assert(g.minY == -20)
      assert(g.maxX == -10)
      assert(g.maxY == -20)
      g:set(-20,-30,2)
      assert(g.maxX == -10)
      assert(g.maxY == -20)
      assert(g.minX == -20)
      assert(g.minY == -30)      
    end,
    
    BoundsCanIncludeZero = function()
      local g = Grid:create()
      g:set(-10,-20,1)
      assert(g.minX == -10)
      assert(g.minY == -20)
      assert(g.maxX == -10)
      assert(g.maxY == -20)
      g:set(20,30,2)
      assert(g.minX == -10)
      assert(g.minY == -20)
      assert(g.maxX == 20)
      assert(g.maxY == 30)      
    end,

  },

  Stack = {
    Create = function()
      local s = Stack:create()
    end,
    
    Push = function()
      local s = Stack:create()
      s:push(true)
    end,
    
    PushMultiple = function()
      local s = Stack:create()
      for x=1,100 do
        s:push({value = x})
      end
      for y=100,1, -1 do
        assert(s:pop().value == y)
      end
    end,
    
    Pop = function()
      local s = Stack:create()
      s:push(true)
      assert(s:pop())
    end,
    
    PopEmpty = function()
      local s = Stack:create()
      assert(s:pop() == nil)
    end,
    
    ClearAfterPush = function()
      local s = Stack:create()
      s:push({})
      s:clear()
      assert(s:pop() == nil)
    end,
    
    ClearEmpty = function()
      local s = Stack:create()
      s:clear()
    end
    
  },
  
  NotifyingStack = {
    Create = function()
      local s = NotifyingStack:create()
    end,
    
    Push = function()
      local s = NotifyingStack:create()
      s:push(true)
    end,
    
    PushIsNotified = function()
      local s = NotifyingStack:create()
      local sensor = false
      s:push({pushed = function() sensor = true end})
      assert(sensor)
    end,
    
    PushMultiple = function()
      local s = NotifyingStack:create()
      for x=1,100 do
        s:push({value = x})
      end
      for y=100,1, -1 do
        assert(s:pop().value == y)
      end
    end,
    
    PushMultipleAreNotified = function()
      local s = NotifyingStack:create()
      local sensor1, sensor2 = false, false
      s:push({pushed = function() sensor1 = true end})
      s:push({pushed = function() sensor2 = true end})
      assert(sensor1)
      assert(sensor2)
    end,
    
    Pop = function()
      local s = NotifyingStack:create()
      s:push(true)
      assert(s:pop())
    end,
    
    PopEmpty = function()
      local s = NotifyingStack:create()
      assert(s:pop() == nil)
    end,
    
    PopIsNotified = function()
      local s = NotifyingStack:create()
      local sensor = false
      s:push({popped = function() sensor = true end})
      s:pop()
      assert(sensor)
    end,
    
    PopAndPushCanBothNotify = function()
      local s = NotifyingStack:create()
      local sensor = 0
      s:push({pushed = function() sensor = 1 end, popped = function() sensor = -1 end})
      assert(sensor == 1)
      s:pop()
      assert(sensor == -1)
    end,
    
    ClearAfterPush = function()
      local s = NotifyingStack:create()
      s:push({})
      s:clear()
      assert(s:pop() == nil)
    end,
    
    ClearEmpty = function()
      local s = NotifyingStack:create()
      s:clear()
    end,
    
    CustomNameForPushedCallback = function()
      local s = NotifyingStack:create("pusher")
      local object = {sensor = 1, pusher = function(o,st) o.sensor = 2 end}
      assert(object.sensor == 1)
      s:push(object)
      assert(object.sensor == 2)
    end,
    
    CustomNameForPoppedCallback = function()
      local s = NotifyingStack:create(nil,"popper")
      local object = {sensor = 1, popper = function(o,st) o.sensor = 2 end}
      assert(object.sensor == 1)
      s:push(object)
      assert(object.sensor == 1)
      s:pop()
      assert(object.sensor == 2)
    end,

    CustomNameForBothCallbacks = function()
      local s = NotifyingStack:create("pusher","popper")
      local object = {sensor = {1,1}, pusher = function(o,st) o.sensor[1] = 2 end, popper = function(o,st) o.sensor[2] = 2 end}
      assert(object.sensor[1] == 1)
      assert(object.sensor[2] == 1)
      s:push(object)
      assert(object.sensor[1] == 2)
      assert(object.sensor[2] == 1)
      s:pop()
      assert(object.sensor[1] == 2)
      assert(object.sensor[2] == 2)
    end,    
    
  },
  
  Heap = {
    Create = function() 
      local h = Heap:create()
    end,
    
    CreateWithComparator = function()
      local h = Heap:create(function(a,b) return a.value < b.value end)
    end,
    
    Insert = function() 
      local h = Heap:create()
      h:insert(3)
    end,
    
    InsertMultiple = function() 
      local h = Heap:create()
      h:insert(3)
      h:insert(1)
      h:insert(5)
      h:insert(2)
      assert(h:checkTop() == 1)
    end,
    
    CheckTop = function() 
      local h = Heap:create()
      h:insert(1)
      assert(h:checkTop() == 1)
    end,
    
    CheckTopEmpty = function() 
      local h = Heap:create()
      assert(h:checkTop() == nil)
    end,
    
    RemoveTop = function() 
      local h = Heap:create()
      h:insert(1)
      assert(h:removeTop() == 1)
    end,
    
    RemoveTopMultiple = function()
      local h = Heap:create()
      h:insert(3)
      h:insert(1)
      h:insert(5)
      h:insert(2)
      assert(h:removeTop() == 1)
      assert(h:removeTop() == 2)
      assert(h:removeTop() == 3)
      assert(h:removeTop() == 5)
      assert(h:removeTop() == nil)
    end,
    
    RemoveTopMultipleWithComparator = function()
      local h = Heap:create(function(a,b) return a > b end)
      h:insert(3)
      h:insert(1)
      h:insert(5)
      h:insert(2)
      assert(h:removeTop() == 5)
      assert(h:removeTop() == 3)
      assert(h:removeTop() == 2)
      assert(h:removeTop() == 1)
      assert(h:removeTop() == nil)
    end,
    
    RemoveTopEmpty = function()
      local h = Heap:create()
      assert(h:removeTop() == nil)
    end,
    
    Clear = function()
      local h = Heap:create()
      h:insert(1)
      h:clear()
      assert(h:checkTop() == nil)
    end,
    
    ClearEmpty = function()
      local h = Heap:create()
      h:clear()
      assert(h:checkTop() == nil)
    end,
  },
  
  PriorityQueue = {
    Create = function() 
      local h = PriorityQueue:create()
    end,
    
    CreateWithComparator = function()
      local h = PriorityQueue:create(function(a,b) return a.value < b.value end)
    end,
    
    Insert = function() 
      local h = PriorityQueue:create()
      h:insert({priority = 1})
    end,
    
    InsertMultiple = function() 
      local h = PriorityQueue:create()
      h:insert({priority = 5})
      h:insert({priority = 1})
      h:insert({priority = 3})
      h:insert({priority = 2})
      assert(h:checkTop().priority == 1)
    end,
    
    CheckTop = function() 
      local h = PriorityQueue:create()
      h:insert({priority = 1})
      assert(h:checkTop().priority == 1)
    end,
    
    CheckTopEmpty = function() 
      local h = PriorityQueue:create()
      assert(h:checkTop() == nil)
    end,
    
    RemoveTop = function() 
      local h = PriorityQueue:create()
      h:insert({priority = 1})
      assert(h:removeTop().priority == 1)
    end,
    
    RemoveTopMultiple = function()
      local h = PriorityQueue:create()
      h:insert({priority = 5})
      h:insert({priority = 1})
      h:insert({priority = 3})
      h:insert({priority = 2})
      assert(h:removeTop().priority == 1)
      assert(h:removeTop().priority == 2)
      assert(h:removeTop().priority == 3)
      assert(h:removeTop().priority == 5)
      assert(h:removeTop() == nil)
    end,
    
    RemoveTopMultipleWithComparator = function()
      local h = PriorityQueue:create(function(a,b) return a > b end)
      h:insert(3)
      h:insert(1)
      h:insert(5)
      h:insert(2)
      assert(h:removeTop() == 5)
      assert(h:removeTop() == 3)
      assert(h:removeTop() == 2)
      assert(h:removeTop() == 1)
      assert(h:removeTop() == nil)
    end,
    
    RemoveTopEmpty = function()
      local h = PriorityQueue:create()
      assert(h:removeTop() == nil)
    end,
    
    Clear = function()
      local h = PriorityQueue:create()
      h:insert({priority = 1})
      h:clear()
      assert(h:checkTop() == nil)
    end,
    
    ClearEmpty = function()
      local h = PriorityQueue:create()
      h:clear()
      assert(h:checkTop() == nil)
    end,

    PriorityRaised = function()
      local h = PriorityQueue:create()
      local a = {priority = 3}
      local b = {priority = 5}
      local c = {priority = 1}
      h:insert(a)
      h:insert(b)
      h:insert(c)
      assert(h:checkTop() == c)
      b.priority = 0
      h:priorityRaised(b)
      assert(h:removeTop() == b)
      assert(h:removeTop() == c)
      assert(h:removeTop() == a)
    end,
    
    PriorityLowered = function()
      local h = PriorityQueue:create()
      local a = {priority = 3}
      local b = {priority = 5}
      local c = {priority = 1}
      h:insert(a)
      h:insert(b)
      h:insert(c)
      assert(h:checkTop() == c)
      c.priority = 4
      h:priorityLowered(c)
      assert(h:removeTop() == a)
      assert(h:removeTop() == c)
      assert(h:removeTop() == b)
    end,
    
  }
}, verboseOutput)
