# frozen_string_literal: true

module Mastermind
  class Coder
    attr_reader :code

    def initialize(code)
      @code = code
    end

    def player_feedback(guess)
      if guess == code
        return true
      end

      feedback = Coder.feedback(@code, guess)

      puts "Computer receives feedback #{feedback}"

      Guesser.computer_receive_feedback(feedback, guess)

      false
    end

    def computer_feedback(guess)
      if guess == code
        return true
      end

      puts "Computer feedbacks #{Coder.feedback(@code, guess)}"

      false
    end

    def self.feedback(code, guess)
      guess_array = guess.split('')
      code_array = code.split('')
      feedback = []

      i = -1
      guess_array.select! do |e|
        i += 1
        if(e == code_array[i])
          code_array[i] = nil
          feedback.push('O')
          false
        else
          true
        end
      end

      code_array.compact!

      while guess_array.length > 0
        n = code_array.find_index(guess_array[0])
        if(n)
          code_array.delete_at(n)
          feedback.push('N')
        end
        guess_array.delete_at(0)
      end

      while(feedback.length < 4)
        feedback.push('X')
      end
      feedback.join()
    end
  end
end
