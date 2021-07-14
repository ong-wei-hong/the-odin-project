# frozen_string_literal: true

module Mastermind
  # Computer calls differentiated action for the computer
  class Computer
    attr_reader :name, :role

    def initialize(role)
      @role = role
      @name = 'Computer'
    end

    def guess
      role.computer_guess
    end

    def feedback(guess)
      role.computer_feedback(guess)
    end
  end
end
