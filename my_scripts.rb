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

  def my_map(var, a_proc = nil)
    arr = []
    for i in 0...var.length do
      unless a_proc.nil?
        arr.push(a_proc.call(var[i]))
      else
        arr.push(yield(var[i]))
      end
    end
    arr
  end

  def my_inject(var, accumulator = nil)
    first_index = 0
    if accumulator.nil?
      accumulator = var[0]
      first_index = 1
    end
    for i in first_index...var.length
      accumulator = yield(accumulator, var[i])
    end
    accumulator
  end

  def multiply_els(var)
    my_inject(var) { |acc, item| acc * item }
  end
end
