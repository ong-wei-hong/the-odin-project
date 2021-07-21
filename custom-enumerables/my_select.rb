# frozen_string_literal

require_relative 'custom_enumerables'

puts '#my_select vs #select'
arr = [1, 2, 3, 4, 5]
p arr.my_select { |e| e > 2}
p arr.select { |e| e > 2 }
puts (arr.my_select { |e| e > 2 }) === (arr.select { |e| e > 2 })

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
p hash.my_select { |k, v| v <= 2 }
p hash.select { |k, v| v <= 2 }
puts (hash.my_select { |k, v| v <= 2 } ) === (hash.select { |k, v| v <= 2 } )
