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

    new_arr = []
    my_each { |item| new_arr.push(item) if yield(item) }
    new_arr
  end

  def my_all?(arg = nil)
    unless arg == nil
      p 'arg not empty'
    if arg.is_a? Class
      my_each do |item| 
        return false unless item.is_a?(arg)
        return true
      end
    elsif arg.is_a? Regexp
      my_each { |item| return false unless item =~ arg }
      return true
    else
      my_each { |item| return false unless item == arg}
      return true
    end
    end
    unless block_given?
      p 'no block given'
      my_each { |item| return false if item == false || item == nil }
      return true
    end
    p 'block given'
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
    new_arr = []
    my_each do |item|
      if a_proc.nil?
        return to_enum unless block_given?

        new_arr.push(yield(item))
      else
        new_arr.push(a_proc.call(item))
      end
    end
    new_arr
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
