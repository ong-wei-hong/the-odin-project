# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while i < self.length
      if Hash === self
        yield self.keys[i], self.values[i]
      else
        yield self[i]
      end
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    while i < self.length
      if Hash === self
        yield [self.keys[i], self.values[i]], i
      else
        yield self[i], i
      end
      i += 1
    end
    self
  end

  def my_select
    arr = []
    hash = {}
    i = 0
    while i < self.length
      if Hash === self
        if yield self.keys[i], self.values[i]
          hash[self.keys[i]] = self.values[i]
        end
      else
        if yield self[i]
          arr << self[i]
        end
      end
      i += 1
    end
    Hash === self ? hash : arr
  end

  def my_all?
    i = 0
    while i < self.length
      if Hash === self
        return false unless yield self.keys[i], self.values[i]
      else
        return false unless yield self[i]
      end
      i += 1
    end
    true
  end

  def my_none?
    i = 0
    while i < self.length
      if Hash === self
        return false if yield self.keys[i], self.values[i]
      else
        return false if yield self[i]
      end
      i += 1
    end
    true
  end

  def my_count
    i = 0
    ans = 0
    while i < self.length
      if Hash === self
        ans += 1 if yield self.keys[i], self.values[i]
      else
        ans += 1 if yield self[i]
      end
      i += 1
    end
    ans
  end

  def my_map(arg = nil)
    if Proc === arg
      if Hash === self
        return my_map { |k, v| arg.call(k, v) }
      else
        return my_map { |e| arg.call(e) }
      end
    end

    i = 0
    arr = []
    while i < self.length
      if Hash === self
        arr << (yield self.keys[i], self.values[i])
      else
        arr << (yield self[i])
      end
      i += 1
    end
    arr
  end

  def my_inject(i = nil)
    arr = self.to_a

    if i.nil?
      ans = arr[0]
      i = 1
    else
      ans = i
      i = 0
    end

    while i < self.length
      ans = yield ans, arr[i]
      i += 1
    end
    ans
  end
end
