# frozen_string_literal: true

module ConnectFour
  # Board handles the state of the board
  class Board
    def initialize
      @board = Array.new(6) { Array.new(7) { '.' } }
    end

    def display
      display = "\n"
      @board.each do |line|
        line.each_with_index do |e, i|
          display += '| ' if i.zero?
          display += "#{e} | "
        end
        display += "\n"
      end
      display += '  1   2   3   4   5   6   7'
    end

    def invalid(pos)
      if /\A[1-7]\z/.match(pos) && @board[0][pos.to_i - 1] == '.'
        false
      else
        true
      end
    end

    def drop(symbol, pos)
      row = row(pos - 1)
      @board[row][pos - 1] = symbol
      winner?(row, pos - 1)
    end

    private

    def row(pos)
      6.times do |i|
        return 5 - i if @board[5 - i][pos] == '.'
      end
    end

    def winner?(x, y)
      vertical(x, y) ||
        horizontal(x, y) ||
        diagonal1(x, y) ||
        diagonal2(x, y)
    end

    def vertical(x, y)
      return false if x > 2

      @board[x][y] == @board[x + 1][y] &&
        @board[x][y] == @board[x + 2][y] &&
        @board[x][y] == @board[x + 3][y]
    end

    def horizontal(x, y)
      a = Array.new(7) { false }
      7.times do |i|
        j = y + i - 3
        a[i] = true if
        j >= 0 &&
        j < 7 &&
        @board[x][y] == @board[x][j]
      end
      a[0] && a[1] && a[2] && a[3] ||
        a[1] && a[2] && a[3] && a[4] ||
        a[2] && a[3] && a[4] && a[5] ||
        a[3] && a[4] && a[5] && a[6]
    end

    def diagonal1(x, y)
      a = Array.new(7) { false }
      i = 0
      while i < 7
        j = x + i - 3
        k = y + i - 3
        a[i] = true if
          j >= 0 && j < 6 &&
          k >= 0 && k < 7 &&
          @board[x][y] == @board[j][k]
        i += 1
      end
      a[0] && a[1] && a[2] && a[3] ||
        a[1] && a[2] && a[3] && a[4] ||
        a[2] && a[3] && a[4] && a[5] ||
        a[3] && a[4] && a[5] && a[6]
    end

    def diagonal2(x, y)
      a = Array.new(7) { false }
      i = 0
      while i < 7
        j = x - i + 3
        k = y + i - 3
        a[i] = true if
          j >= 0 && j < 6 &&
          k >= 0 && k < 7 &&
          @board[x][y] == @board[j][k]
        i += 1
      end
      a[0] && a[1] && a[2] && a[3] ||
        a[1] && a[2] && a[3] && a[4] ||
        a[2] && a[3] && a[4] && a[5] ||
        a[3] && a[4] && a[5] && a[6]
    end
  end
end
