# frozen_string_literal: true

class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  def initialize(arr)
    @root = build_tree(arr.uniq.sort)
  end

  # thanks top!
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data, node = @root)
    return Node.new(data) if node.nil?

    if data > node.data
      node.right = insert(data, node.right)
    elsif data < node.data
      node.left = insert(data, node.left)
    else # data == node.data
      return node
    end

    node
  end

  def delete(data, node = @root)
    return nil if node.nil?

    if data < node.data
      node.left = delete(data, node.left)
    elsif data > node.data
      node.right = delete(data, node.right)
    else
      if node.left.nil? && node.right.nil?
        return nil
      elsif node.left.nil? || node.right.nil?
        return node.right || node.left
      end

      to_delete = min_value(node.right)
      node.data = to_delete.data
      node.right = delete(to_delete.data, node.right)
    end
    node
  end

  def find(data)
    curr_node = @root
    until curr_node.nil?
      if data > curr_node.data
        curr_node = curr_node.right
      elsif data < curr_node.data
        curr_node = curr_node.left
      else # data == curr_node.data
        break
      end
    end
    curr_node
  end

  # def level_order(arr = [], node = @root, queue = [])
    # queue << node.left unless node.left.nil?
    # queue << node.right unless node.right.nil?
    # arr << node.data
    # return arr if queue.empty?

    # level_order(arr, queue.shift, queue)
  # end

  def level_order
    return [] if @root.nil?

    arr = []
    queue = []
    node = @root

    loop do
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
      arr << node.data

      break if queue.empty?

      node = queue.shift
    end
    arr
  end

  def inorder(node = @root, arr = [])
    arr = inorder(node.left, arr) unless node.left.nil?
    arr << node.data unless node.nil?
    arr = inorder(node.right, arr) unless node.right.nil?

    arr
  end

  def preorder(node = @root, arr = [])
    arr << node.data unless node.nil?
    arr = preorder(node.left, arr) unless node.left.nil?
    arr = preorder(node.right, arr) unless node.right.nil?

    arr
  end

  def postorder(node = @root, arr = [])
    arr = postorder(node.left, arr) unless node.left.nil?
    arr = postorder(node.right, arr) unless node.right.nil?
    arr << node.data unless node.nil?

    arr
  end

  def height(node, curr_node = node, height = 0)
    return height if curr_node.nil?

    [height(node, curr_node.left, height + 1), height(node, curr_node.right, height + 1)].max
  end

  def depth(node, curr_node = @root, depth = 1)
    return nil if curr_node.nil?
    return depth if node == curr_node

    depth(node, curr_node.left, depth + 1) || depth(node, curr_node.right, depth + 1)
  end

  def balanced?(node=@root)
    return true if node.nil?

    l = height(node.left)
    r = height(node.right)

    return true if balanced?(node.left) && balanced?(node.right) && (l - r).abs <= 1
    false
  end

  def rebalance
    arr = level_order
    @root = build_tree(arr.sort)
  end

  private

  def min_value(node)
    curr_node = node
    until curr_node.left.nil?
      curr_node = curr_node.left
    end
    curr_node
  end

  def build_tree(arr)
    return nil if arr.empty?

    mid = (arr.size - 1) / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr[0...mid])
    node.right = build_tree(arr[mid + 1..-1])

    node
  end
end
