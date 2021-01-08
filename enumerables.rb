# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/ModuleLength

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
    unless arg.nil?
      if arg.is_a? Class
        my_each do |item|
          return false unless item.is_a?(arg)
        end
      elsif arg.is_a? Regexp
        my_each { |item| return false unless item =~ arg }
      else
        my_each { |item| return false unless item == arg }
      end
      return true
    end
    unless block_given?
      my_each { |item| return false unless item }
      return true
    end
    result = false
    my_each do |item|
      result = yield(item)
      break if result == false
    end
    result
  end

  def my_any?(arg = nil)
    unless arg.nil?
      if arg.is_a? Class
        my_each do |item|
          return true if item.is_a?(arg)
        end
      elsif arg.is_a? Regexp
        my_each { |item| return true if item =~ arg }
      else
        my_each { |item| return true if item == arg }
      end
      return false
    end
    unless block_given?
      my_each { |item| return true if item }
      return false
    end
    result = false
    my_each do |item|
      result = yield(item)
      break if result == true
    end
    result
  end

  def my_none?(arg = nil)
    unless arg.nil?
      if arg.is_a? Class
        my_each do |item|
          return false if item.is_a?(arg)
        end
      elsif arg.is_a? Regexp
        my_each { |item| return false if item =~ arg }
      else
        my_each { |item| return false if item == arg }
      end
      return true
    end
    unless block_given?
      my_each { |item| return false if item }
      return true
    end
    result = true
    my_each do |item|
      result = yield(item)
      return false if result == true
    end
    true
  end

  def my_count(arg = nil)
    ans = 0
    unless arg.nil?
      my_each do |item|
        ans += 1 if item == arg
      end
      return ans
    end
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

  def my_inject(acc = nil, opp = nil)
    return raise LocalJumpError, 'No block or argument is given' if !block_given? && acc.nil? && opp.nil?

    if !block_given?
      if opp.nil?
        opp = acc
        acc = nil
      end
      opp.to_sym
      my_each do |item|
        acc = if acc.nil?
                item
              else
                acc.send(opp, item)
              end
      end
    else
      my_each do |item|
        acc = if acc.nil?
                item
              else
                yield(acc, item)
              end
      end
    end
    acc
  end
end

def multiply_els(array)
  array.my_inject(:*)
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/ModuleLength
