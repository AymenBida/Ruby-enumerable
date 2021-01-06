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
end
