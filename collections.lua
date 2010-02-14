require("base")

Grid = {
  
  create = function(g,opts)
    return Base:create(g):mixin(opts)
  end,
  
  set = function(g,x,y,value)
    if g[x] == nil then g[x] = {} end
    g[x][y] = value
  end,
  
  get = function(g,x,y)
    if g[x] == nil then return nil end
    return g[x][y]
  end,
}


Stack = {

  create = function(s)
    return Base:create(Stack):clear()
  end,

  push = function(s,element)
    table.insert(s.elements, element)
  end,
  
  pop = function(s)
    if #s.elements > 0 then
      return table.remove(s.elements)
    else
      return nil
    end
  end,
  
  peek = function(s)
    if #s.elements > 0 then
      return s.elements[#s.elements]
    else
      return nil
    end
  end,

  clear = function(s)
    s.elements = {}
    return s
  end
  
}

NotifyingStack = {
  create = function(s, pushedCallbackName, poppedCallbackName) 
    local result = Stack:create():mixin(NotifyingStack)
    result.pushedCallback = pushedCallbackName or "pushed"
    result.poppedCallback = poppedCallbackName or "popped"
    return result
  end,
  
  push = function(s, element)
    Stack.push(s, element)
    local pushedCallback = s.pushedCallback
    if type(element) == "table" and element[pushedCallback] ~= nil then element[pushedCallback](element,s) end
  end,
  
  pop = function(s)
    local result = Stack.pop(s)
    local poppedCallback = s.poppedCallback
    if type(result) == "table" and result[poppedCallback] ~= nil then result[poppedCallback](result,s) end
    return result
  end
}



Heap = {
  create = function(self, comparator)
    local result = Base:create(Heap):clear()
    if comparator == nil then comparator = Heap._compareNumbers end
    result.comparator = comparator
    return result
  end,
  
  insert = function(self, element)
    local e = self.elements
    table.insert(e, element)
    local index = #(self.elements)
    self.indices[element] = index
    return self:_bubbleUp(element, index)
  end,
  
  checkTop = function(self)
    return self.elements[1]
  end,  
  
  removeTop = function(self)
    if #self.elements == 0 then return nil end
    local result = self.elements[1]
    self.indices[result] = nil
    
    if #(self.elements) > 1 then
      local item = table.remove(self.elements)
      self.elements[1] = item

      self:_bubbleDown(item, 1)
      return result
    
    elseif #(self.elements) == 1 then
      return table.remove(self.elements)
    
    else
      return nil
    end
    
  end,
  
  clear = function(self)
    self.elements = {}
    self.indices = {}
    return self
  end,
  
  _compareNumbers = function(a,b) return a < b end,
  
  _indexOf = function(self, element)
    return self.indices[element]
  end,
  
  _leftIndexOf = function(self, index)
    return 2*index
  end,
  
  _rightIndexOf = function(self, index)
    return 2*index + 1 
  end,
  
  _parentIndexOf = function(self, index)
    return math.floor(index/2)
  end,
   
  _bubbleUp = function(self, element, index)
    local e = self.elements 
    local parentIndex = self:_parentIndexOf(index)
    local parent = e[parentIndex]
    if parent == nil or self.comparator(parent, element) then
      return nil
    else
      e[index], e[parentIndex] = e[parentIndex], e[index]
      self.indices[element] = parentIndex
      return self:_bubbleUp(element, parentIndex)
    end
  end,
 
  _bubbleDown = function(self, item, index)
    local e, i = self.elements, self.indices
    local swapIndex = nil
    local rightChildIndex = self:_rightIndexOf(index)
    local leftChildIndex = self:_leftIndexOf(index)
    
    local rightChild = self.elements[rightChildIndex]
    local leftChild = self.elements[leftChildIndex]
    
    if leftChild ~= nil and rightChild ~= nil then
      if self.comparator(leftChild, rightChild) then
        if self.comparator(leftChild, item) then swapIndex = leftChildIndex; i[leftChild] = index end
      else
        if self.comparator(rightChild, item) then swapIndex = rightChildIndex; i[rightChild] = index end
      end
    elseif leftChild == nil and rightChild ~= nil then
      if self.comparator(rightChild, item) then swapIndex = rightChildIndex; i[rightChild] = index end
    elseif leftChild ~= nil and rightChild == nil then
      if self.comparator(leftChild, item) then swapIndex = leftChildIndex; i[leftChild] = index end
    end
    
    if swapIndex == nil then
      return nil
    else
      e[index], e[swapIndex] = e[swapIndex], e[index]
      i[item] = swapIndex
      return self:_bubbleDown(item, swapIndex)
    end
  end,
 
}


PriorityQueue = {

  create = function(self, comparator)
    if comparator == nil then comparator = PriorityQueue.comparePriorities end
    return Heap:create(comparator):mixin(PriorityQueue)
  end,

  comparePriorities = function(item1, item2) return item1.priority < item2.priority end,
  
  priorityRaised = function(self, element)
    local i = self:_indexOf(element)
    if i ~= nil then
      self:_bubbleUp(element, i)
    end
  end,
  
  priorityLowered = function(self, element)
    local i = self:_indexOf(element)
    if i ~= nil then
      self:_bubbleDown(element, i)
    end
  end,
  
}