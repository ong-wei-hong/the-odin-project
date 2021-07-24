#frozen_string_literal: true

require_relative 'binary_search_tree'

puts 'building tree'
tree = Tree.new(Array.new(15) { rand(1..100) } )

tree.pretty_print

puts "\n#balanced?\t#{tree.balanced?}"

puts "\nlevel order\t#{tree.level_order}\npre order\t#{tree.preorder}\npost order\t#{tree.postorder}\nin order\t#{tree.inorder}"

puts "\ninserting 10 numbers > 100"
10.times { tree.insert(rand(101..1000)) }

tree.pretty_print

puts "\n#balanced?\t#{tree.balanced?}"

puts "\n#rebalance"
tree.rebalance
tree.pretty_print

puts "\n#balanced?\t#{tree.balanced?}"

puts "\nlevel order\t#{tree.level_order}\npre order\t#{tree.preorder}\npost order\t#{tree.postorder}\nin order\t#{tree.inorder}"
