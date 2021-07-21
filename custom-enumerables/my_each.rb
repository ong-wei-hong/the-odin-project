# frozen_string_literal: true

require_relative 'custom_enumerables'

puts "#my_each vs #each"
arr = [1, 2, 3, 4, 5]
puts (arr.my_each { |e| puts e } ) === (arr.each { |e| puts e } )

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
puts (hash.my_each { |k, v| puts "#{k}\t#{v}" } ) === (hash.each { |k, v| puts "#{k}\t#{v}" } )
