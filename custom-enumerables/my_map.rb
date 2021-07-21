# frozen_string_literal: true

require_relative 'custom_enumerables'

puts '#my_map vs #map'
arr = [1, 2, 3, 4, 5]
p arr.my_map { |e| e * 3 }
p arr.map { |e| e * 3 }
puts (arr.my_map { |e| e * 3 }) == (arr.map { |e| e * 3 })

proc = Proc.new { |k, v| [v, k] }
hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
p hash.my_map(&proc)
p hash.map(&proc)
puts (hash.my_map(&proc)) == (hash.map(&proc))
