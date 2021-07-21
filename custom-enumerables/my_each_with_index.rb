# frozen_string_literal: true

require_relative 'custom_enumerables'

puts '#my_each_with_index vs #each_with_index'
arr = [1, 2, 3, 4, 5]
puts (arr.my_each_with_index { |e, i| puts "#{i}\t#{e}" }) === (arr.each_with_index { |e, i| puts "#{i}\t#{e}" })

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
puts (hash.my_each_with_index { |e, i| puts "#{i}\t#{e}" } ) === (hash.each_with_index { |e, i| puts "#{i}\t#{e}" } )
