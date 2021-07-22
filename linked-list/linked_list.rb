# frozen_string_literal: true

class LinkedList
  attr_reader :size

  class Node
    attr_reader :value
    attr_accessor :next_node

    def initialize(value = nil)
      @value = value
      @next_node = nil
    end
  end

  def initialize
    @start = Node.new
    @size = 0
  end

  def append(value)
    self.tail.next_node = Node.new(value)
    @size += 1
  end

  def prepend(value)
    new_node = Node.new(value)
    new_node.next_node = @start.next_node
    @start.next_node = new_node
    @size += 1
  end

  def head
    @start.next_node
  end

  def tail
    curr_node = @start
    curr_node = curr_node.next_node until(curr_node.next_node.nil?)
    curr_node
  end

  def at(index)
    return if index >= @size || index < 0

    curr_node = @start.next_node
    while(index.positive?)
      curr_node = curr_node.next_node
      index -= 1
    end
    curr_node
  end

  def pop
    curr_node = @start
    next_node = @start.next_node
    until(next_node.next_node.nil?)
      curr_node = next_node
      next_node = next_node.next_node
    end
    curr_node.next_node = nil
    @size -= 1
    next_node
  end

  def contains?(value)
    curr_node = @start
    until(curr_node.next_node.nil?)
      return true if(curr_node.value == value)
      curr_node = curr_node.next_node
    end
    false
  end

  def find(value)
    index = 0
    curr_node = @start.next_node
    until(curr_node.next_node.nil?)
      return index if(curr_node.value == value)
      curr_node = curr_node.next_node
      index += 1
    end
    nil
  end

  def to_s
    return 'nil' if size == 0

    curr_node = @start.next_node
    string = "( #{curr_node.value} )"
    until(curr_node.next_node.nil?)
      curr_node = curr_node.next_node
      string += " -> ( #{curr_node.value} )"
    end
    return string + ' -> nil'
  end

  def insert_at(value, index)
    return self.prepend(value) if index == 0
    return if index > @size || index < 0

    curr_node = Node.new(value)
    curr_node.next_node = self.at(index)
    self.at(index - 1).next_node = curr_node
    @size += 1
  end

  def remove_at(index)
    return shift if index == 0
    return if index >= @size || index < 0

    removed = self.at(index)
    self.at(index - 1).next_node = removed.next_node
    @size -= 1
    removed
  end

  private
  def shift
    removed = @start.next_node
    @start.next_node = removed.next_node
    @size -= 1
    removed
  end
end
