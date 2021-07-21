# frozen_string_literal: true

require_relative 'custom_enumerables'

puts '#my_none? vs #none?'
arr = [1, 2, 3, 4, 5]
puts arr.my_none? { |e| e > 0 }
puts arr.none? { |e| e > 0 }
puts (arr.my_none? { |e| e > 0 }) == (arr.none? { |e| e > 0 })

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
puts hash.my_none? { |k, v| v > 5 }
puts hash.none? { |k, v| v > 5 }
puts (hash.my_none? { |k, v| v > 5 } ) == (hash.none? { |k, v| v > 5 } )
