# frozen_string_literal: true

require_relative 'linked_list'

numbers = LinkedList.new

puts "testing #append\nexpect linked list of 4 3 2 1 0 of size 5"
5.times { |i| numbers.append(4 - i) }
puts "#{numbers}\nsize: #{numbers.size}"

puts "\ntesting #prepend\nexpect linked list of 5 4 3 2 1 of size 6"
numbers.prepend(5)
puts "#{numbers}\nsize: #{numbers.size}"

puts "\ntesting #head\nexpect head object, value and next_node\n#{numbers.head} #{numbers.head.value} #{numbers.head.next_node}"

puts "\ntesting #tail\nexpect tail object, value and next_node\n#{numbers.tail} #{numbers.tail.value} #{numbers.tail.next_node}"

puts "\ntesting #at\nexpect 5 4 3 2 1 0, #at(6) == nil, #at(-1) == nil"
numbers.size.times { |i| puts numbers.at(i).value }
puts "#at(6): #{numbers.at(6)}\n#at(-1): #{numbers.at(-1)}"

puts "\ntesting #pop\nexpect pop.value = 0, tail.value = 1, size = 5\nnumbers.pop.value: #{numbers.pop.value}\nnumbers.tail.value: #{numbers.tail.value}\nsize: #{numbers.size}"

puts "\ntesting #contains?\nexpect #contains?(4) == true, #contains?(0) == false\n#contains?(4): #{numbers.contains?(4)}\n#contains?(0): #{numbers.contains?(0)}"

puts "\ntesting #find\nexpect #find(5) == 0, #find(2) == 3, #find(0) == nil\n#find(5): #{numbers.find(5)}\n#find(2): #{numbers.find(2)}\n#find(0): #{numbers.find(0)}"

puts "\ntesting #to_s\nexpect linked list of 5 4 3 2 1\n#{numbers}"

puts "\ntesting #insert_at(value, index)\nexpect #insert_at(6, 0) to give linked list of 6 5 4 3 2 1 of size 6:"
numbers.insert_at(6, 0)
puts "#{numbers}\nsize: #{numbers.size}\nexpect #insert_at(0, 6) to give linked list of 6 5 4 3 2 1 0 of size 7: "
numbers.insert_at(0, 6)
puts "#{numbers}\nsize: #{numbers.size}\nexpect #insert_at(3.5, 3) to give linked list of 6 5 4 3.5 3 2 1 0 of size 8: "
numbers.insert_at(3.5, 3)
puts "#{numbers}\nsize: #{numbers.size}\nexpect #insert_at(-2, 9) to yield no change"
numbers.insert_at(-2, 9)
puts "#{numbers}\nexpect #insert_at(8, -1) to yield no change"
numbers.insert_at(8, -1)
puts numbers

puts "\ntesting #remove_at(index)\nexpect #remove_at(0) to return 6 and give linked list of 5 4 3.5 3 2 1 0 of size 7\nremoved: #{numbers.remove_at(0).value}\n#{numbers}\nsize: #{numbers.size}\nexpect #remove_at(6) to return 0 and give a linked list of 5 4 3.5 3 2 1 of size 6\nremoved: #{numbers.remove_at(6).value}\n#{numbers}\nsize: #{numbers.size}\nexpect #remove_at(2) to return 3.5 and give a linked list of 5 4 3 2 1 of size 5\nremoved: #{numbers.remove_at(2).value}\n#{numbers}\nsize: #{numbers.size}\nexpect #remove_at(5) to yield no change"
numbers.remove_at(5)
puts "#{numbers}\nexpect #remove_at(-1) to yield no change"
numbers.remove_at(-1)
puts "#{numbers}\nFinal linked list for comparison:\n#{numbers}\nsize: #{numbers.size}"
