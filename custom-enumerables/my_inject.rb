# frozen_string_literal: true

require_relative 'custom_enumerables'

puts '#my_inject vs #inject'
arr = [1, 2, 3, 4, 5]
puts arr.my_inject { |sum, n| sum += n }
puts arr.inject { |sum, n| sum += n }
puts (arr.my_inject { |sum, n| sum += n }) == (arr.inject { |sum, n| sum += n })

hash = {one: 1, two: 2, three: 3, four: 4, five: 5}
p hash.my_inject(['check']) { |sum, n| sum += n }
p hash.inject(['check']) { |sum, n| sum += n }
puts (hash.my_inject(['check']) { |sum, n| sum += n } ) == (hash.inject(['check']) { |sum, n| sum += n } )

def multiply_els(arr)
  arr.inject{ |sum, n| sum * n}
end

puts multiply_els([2, 4, 5])
