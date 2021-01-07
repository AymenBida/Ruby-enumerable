module Enumerable
  def my_each
    return to_enum unless block_given?
    arr = to_a
    arr.length.times { |item| yield(arr[item]) }
    self
  end

  def my_each_with_index
    return to_enum unless block_given?
    arr = to_a
    arr.length.times { |item| yield(arr[item], item) }
    self
  end

  def my_select
    return to_enum unless block_given?
    newArr = []
    my_each { |item| newArr.push(item) if yield(item) }
    newArr
  end

  def my_all?
    unless block_given?
        my_each { |item| return false if item == false }
        return true
    end
    result = false
    my_each do |item|
      result = yield(item)
      break if result == false
    end
    result
  end

  def my_any?
    unless block_given?
        my_each { |item| return true if item == true }
        return false
    end
    result = false
    my_each do |item|
      result = yield(item)
      break if result == true
    end
    result
  end

  def my_none?
    unless block_given?
        my_each { |item| return false if item == true }
        return true
    end
    result = true
    my_each do |item|
      result = yield(item)
      return false if result == true
    end
    true
  end

  def my_count
    ans = 0
    if block_given?
      my_each do |item|
        ans += 1 if yield(item)
      end
    else
      my_each { ans += 1 }
    end
    ans
  end

  def my_map(a_proc = nil)
    newArr = []
    my_each do |item|
      if a_proc.nil?
        return to_enum unless block_given?
        newArr.push(yield(item))
      else
        newArr.push(a_proc.call(item))
      end
    end
    newArr
  end

  def my_inject(accumulator = nil)
    return raise LocalJumpError, 'no block given' unless block_given?
    arr = to_a
    first_index = 0
    if accumulator.nil?
      accumulator = arr[0]
      first_index = 1
    end
    while first_index < arr.length
        accumulator = yield(accumulator, arr[first_index])
        first_index += 1
    end
    accumulator
  end

  def multiply_els(var)
    var.my_inject { |acc, item| acc * item }
  end
end
