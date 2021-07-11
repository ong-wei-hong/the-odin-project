# frozen_string_literal: true

module TicTacToe
  # the Game class manages the moves and turns of the players
  class Game
    attr_reader :players, :board, :current_player, :other_player

    def initialize(players, board = Board.new)
      @players = players
      @board = board
      @current_player, @other_player = players.shuffle
    end

    def switch_players
      @other_player, @current_player = @current_player, @other_player
    end

    def solicit_move
      "#{current_player.name}: Enter a number between 1 to 9 to make your move"
    end

    def get_move(human_move = gets.chomp)
      human_move_to_coordinate(human_move)
    end

    def game_over_message
      return "#{current_player.name} won!" if board.game_over == :winner
      return 'The game ended in a tie' if board.game_over == :draw
    end

    def play
      puts "#{current_player.name} has randomly been selected as the first player"
      loop do
        board.formatted_grid
        puts ''
        puts solicit_move
        x, y = get_move
        board.set_cell(x, y, current_player.color)
        if board.game_over
          puts game_over_message
          board.formatted_grid
          return
        else
          switch_players
        end
      end
    end

    private

    def human_move_to_coordinate(human_move)
      [(human_move.to_i + 2) % 3, (human_move.to_i - 1) / 3]
    end
  end
end
