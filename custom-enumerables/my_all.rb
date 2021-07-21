# frozen_string_literal: true

require_relative 'custom_enumerables'

puts '#my_all? vs #all?'
arr = [1, 2, 3, 4, 5]
puts arr.my_all? { |e| e > 0 }
puts arr.all? { |e| e > 0 }
puts (arr.my_all? { |e| e > 0 }) == (arr.all? { |e| e > 0 })

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
puts hash.my_all? { |k, v| v > 5 }
puts hash.all? { |k, v| v > 5 }
puts (hash.my_all? { |k, v| v > 5 } ) == (hash.all? { |k, v| v > 5 } )
