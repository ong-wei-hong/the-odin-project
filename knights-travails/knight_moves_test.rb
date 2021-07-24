# frozen_string_literal: true

require_relative 'knight_moves'

puts 'knight_moves([0, 0], [1, 2])'
knight_moves([0, 0], [1, 2])

puts "\nknights_moves([0, 0], [3, 3])"
knight_moves([0, 0], [3, 3])

puts "\nknights_moves([3, 3], [0, 0])"
knight_moves([3, 3], [0, 0])

puts "\nknights_moves([3, 3], [4, 3])"
knight_moves([3, 3], [4, 3])
