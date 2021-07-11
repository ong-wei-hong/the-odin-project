# frozen_string_literal: true

module TicTacToe
  # a player is able to play the game
  class Player
    attr_reader :color, :name

    def initialize(input)
      @color = input.fetch(:color)
      @name = input.fetch(:name)
    end
  end
end
