# frozen_string_literal: true

module ConnectFour
  # Player handles player's actions
  class Player
    attr_reader :symbol

    def initialize(symbol, board)
      @symbol = symbol
      @board = board
    end

    def ask
      puts 'enter column number: '
      pos = gets.chomp
      while @board.invalid(pos)
        puts "\ninvalid input\nplease enter a number from 1 to 7 which column is not full"
        pos = gets.chomp
      end
      pos.to_i
    end
  end
end
