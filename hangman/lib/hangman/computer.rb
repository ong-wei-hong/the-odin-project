# frozen_string_literal: true

module Hangman
  # Computer handles the word state and previous guesses
  class Computer
    attr_reader :word, :word_state, :previous_guesses

    def initialize(word, word_state = Array.new(word.length, '_'), previous_guesses = [])
      @word = word
      @word_state = word_state
      @previous_guesses = previous_guesses
    end

    def get_word_state
      @word_state.join(' ')
    end

    def receive(char)
      return :repeat if previous_guesses.include?(char)

      @previous_guesses << char

      guess = false
      @word_state.each_with_index do |_, i|
        if word[i] == char
          @word_state[i] = char
          guess = true
        end
      end

      return :complete unless @word_state.include?('_')

      return :correct if guess

      :wrong
    end
  end
end
