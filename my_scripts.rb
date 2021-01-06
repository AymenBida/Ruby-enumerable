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
end
