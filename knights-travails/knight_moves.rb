# frozen_string_literal: true


def knight_moves(i, j)
  solution = get_solution(i, j)

  puts "You made it in #{solution.length} moves! Here's your path:"
  solution.each { |e| p e }
end

def get_solution(i, j)
  moves = get_moves

  queue = [[i]]

  until queue[0][-1] == j
    queue += moves
    .map { |move| queue[0] + [[queue[0][-1][0] + move[0], queue[0][-1][1] + move[1]]]}
    .select { |sequence| inside_board?(sequence[-1][0], sequence[-1][1]) }
    queue.shift
  end

  queue[0]
end

def get_moves
  [-2, -1, 1, 2].permutation(2).select { |e| e[0].abs != e[1].abs }
end

def inside_board?(x, y)
  x >= 0 && x <= 7 && y >= 0 && y <= 7
end
