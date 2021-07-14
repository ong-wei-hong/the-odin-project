# frozen_string_literal: true

module Mastermind
  # Coder handles the feedback system and stores the code
  class Coder
    attr_reader :code

    def initialize(code)
      @code = code
    end

    def player_feedback(guess)
      return true if guess == code

      feedback = Coder.feedback(@code, guess)
      puts "Computer receives feedback #{feedback}\n\n"
      Guesser.computer_receive_feedback(feedback, guess)
      false
    end

    def computer_feedback(guess)
      return true if guess == code

      puts "Computer feedbacks #{Coder.feedback(@code, guess)}\n\n"

      false
    end

    def self.feedback(code, guess)
      guess_array = guess.split('')
      code_array = code.split('')
      feedback = []

      i = -1
      guess_array.select! do |e|
        i += 1
        if e == code_array[i]
          code_array[i] = nil
          feedback.push('O')
          false
        else
          true
        end
      end

      code_array.compact!

      while guess_array.length.positive?
        n = code_array.find_index(guess_array[0])
        if n
          code_array.delete_at(n)
          feedback.push('N')
        end
        guess_array.delete_at(0)
      end

      feedback.push('X') while feedback.length < 4

      feedback.join
    end
  end
end
