module Enumerable
  def my_each(var)
    if block_given?
      for i in 0...var.length
        yield(var[i])
      end
      var
    else 'Error: no block given'
    end
  end

  def my_each_with_index(var)
    if block_given?
      for i in 0...var.length
        yield(var[i], i)
      end
      var
    else 'Error: no block given'
    end
  end
  
  def my_select(var)
    arr = []
    my_each(var) do |item|
      if yield(item) 
        arr.push(item)
      end
    end
    arr
  end

  def my_all?(var)
    result = false
    my_each(var) do |item|
      result = yield(item)
      break if result == false
    end
    result
  end

  def my_any?(var)
    result = false
    my_each(var) do |item|
      result = yield(item)
      break if result == true
    end
    result
  end

  def my_none?(var)
    result = true
    my_each(var) do |item|
      result = yield(item)
      if result == true
        return false
      end
    end
    true
  end

  def my_count(var)
    ans = 0
    if block_given?
      my_each(var) do |item|
        if yield(item) 
          ans += 1
        end
      end
    else
      my_each(var) { ans += 1 }
    end
    ans
  end

  def my_map(var)
    arr = []
    if block_given?
      for i in 0...var.length
        yield(var[i])
        arr.push(yield(var[i]))
      end
      arr
    else 'Error: no block given'
    end
  end
end
