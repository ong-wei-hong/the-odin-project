# frozen_string_literal: true

require_relative 'binary_search_tree'

puts 'Testing binary_search_tree'

puts "\n#initialise\n\nexpect bst with values [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]"
tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print

puts "\n#insert\n\nexpect #insert(1) to yield no change"
tree.insert(1)
tree.pretty_print

puts "\nexpect #insert(0) to insert 0 to the left of 1"
tree.insert(0)
tree.pretty_print

puts "\nexpect #insert(25) to insert 25 to the right of 23"
tree.insert(25)
tree.pretty_print

puts "\n#delete\n\nexpect #delete(6345) to remove 6345"
tree.delete(6345)
tree.pretty_print

puts "\nexpect #delete(9) to replace 9 with its right branch"
tree.delete(9)
tree.pretty_print

puts "\nafter inserting -1 -2, expect #delete(0) to replace 0 with its left branch"
tree.insert(-1)
tree.insert(-2)
puts 'tree after insertion'
tree.pretty_print
puts "\ntree after #delete(0)"
tree.delete(0)
tree.pretty_print

puts "\nafter inserting 24, 26 expect #delete(8) to replace 8 with 23 and the tree to maintain bst structure"
tree.insert(24)
tree.insert(26)
puts 'tree after insertion'
tree.pretty_print
puts "\ntree after #delete(8)"
tree.delete(8)
tree.pretty_print

puts "\nexpect #delete(-3) to yield no change"
tree.delete(-3)
tree.pretty_print

puts "\n#find\n\nexpect #find(-3) to return nil"
puts "#find(-3): #{tree.find(-3)}"
puts "\nexpect #find(26) to return a node\n#find(26): #{tree.find(26)}"

puts "\n#level_order\n\nexpect the level order of tree"
p tree.level_order

puts "\n#inorder\n\nexpect the in order array of tree"
p tree.inorder

puts "\n#preorder\n\nexpect the pre order array of tree"
p tree.preorder

puts "\n#postorder\n\nexpect the post order array of tree"
p tree.postorder

puts "\n#height\n\nexpect height of root == 5"
puts tree.height(tree.find(23))

puts "\nexpect height of -2 == 1"
puts tree.height(tree.find(-2))

puts "\n#depth\n\nexpect depth of root == 1"
puts tree.depth(tree.find(23))

puts "\nexpect depth of 26 == 4"
puts tree.depth(tree.find(26))

puts "\n#balanced?\n\nexpect tree to be balanced"
puts tree.balanced?

puts "\nafter inserting -3, expect tree to be unbalanced"
tree.insert(-3)
puts "tree after inserting -3"
tree.pretty_print
puts "#balanced?"
puts tree.balanced?

puts "\n#rebalance\n\nexpect balanced tree"
tree.rebalance
tree.pretty_print
