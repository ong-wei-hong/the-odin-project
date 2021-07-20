# frozen_string_literal: true

module Hangman
  # Player handles number of remaining guesses and asks for input
  class Player
    attr_accessor :remaining_guesses

    def initialize(remaining_guesses = 10)
      @remaining_guesses = remaining_guesses
    end

    def guess
      c = gets.chomp

      while c.length != 1 || c.downcase.ord < 97 || c.downcase.ord > 122
        return :save if c == 'save'

        puts "\nInput not recognised\nEnter an alphabet: (or save to save the game)"
        c = gets.chomp
      end
      c.downcase
    end
  end
end
