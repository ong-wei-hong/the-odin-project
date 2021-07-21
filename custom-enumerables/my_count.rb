# frozen_string_litercount: true

require_relative 'custom_enumerables'

puts '#my_count vs #count'
arr = [1, 2, 3, 4, 5]
puts arr.my_count { |e| e > 2 }
puts arr.count { |e| e > 2 }
puts (arr.my_count { |e| e > 2 }) == (arr.count { |e| e > 2 })

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
puts hash.my_count { |k, v| v < 4 }
puts hash.count { |k, v| v < 4 }
puts (hash.my_count { |k, v| v < 4 } ) == (hash.count { |k, v| v < 4 } )
