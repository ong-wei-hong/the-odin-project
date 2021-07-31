# frozen_string_literal: true

module ConnectFour
  # Game handles the sequence of events
  class Game
    def play
      initialize_game
      winner = false

      21.times do
        puts @board.display
        if turn(@player1, 1)
          congrats(1)
          winner = true
          break
        end
        puts @board.display
        if turn(@player2, 2)
          congrats(2)
          winner = true
          break
        end
      end
      draw unless winner
    end

    private

    def initialize_game
      puts 'Welcome to Connect Four'
      @board = Board.new
      @player1 = Player.new('X', @board)
      @player2 = Player.new('O', @board)
    end

    def turn(player, num)
      puts "\nplayer #{num} turn"
      pos = player.ask
      @board.drop(player.symbol, pos)
    end

    def congrats(num)
      puts @board.display, "congrats, player #{num} wins!"
    end

    def draw
      puts @board.display, 'its a draw'
    end
  end
end
