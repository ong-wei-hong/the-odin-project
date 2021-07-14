# frozen_string_literal: true

module Mastermind
  # Guesser will handle the computer and player action with the role of guesser
  class Guesser
    attr_reader :possible_guesses

    def initialize (computer = false)
      if(computer)
        digits = ['1', '2', '3', '4', '5', '6']
        @@possible_guesses = digits.repeated_permutation(4).to_a
        @@possible_guesses.map! { |a| a.join() }
      end
    end

    def possible_guesses
      @@possible_guesses
    end

    def player_guess
      puts 'Guess the secret code:'
      code = gets.chomp
      if(!code.code_valid?)
        puts "WARNING: This code is not valid. (Only 1 warning will be given)\nEnter code:"
        code = gets.chomp
      end
      code
    end

    def computer_guess
      puts "Computer guesses #{@@possible_guesses[0]}"
      @@possible_guesses[0]
    end

    def self.computer_receive_feedback(feedback, guess)
      @@possible_guesses.select! do |e|
        Coder.feedback(e, guess) == feedback
      end
    end
  end
end
