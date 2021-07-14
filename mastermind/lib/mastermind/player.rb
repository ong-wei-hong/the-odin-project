# frozen_string_literal: true

module Mastermind
  # Player stores the name and calls differentiated actions for the player
  class Player
    attr_reader :name, :role

    def initialize(name, role)
      @name = name
      @role = role
    end

    def guess
      role.player_guess
    end

    def feedback(guess)
      role.player_feedback(guess)
    end
  end
end
