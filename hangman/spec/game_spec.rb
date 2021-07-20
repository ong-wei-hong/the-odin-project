# frozen_string_literal: true

require 'spec_helper'

module Hangman
  describe Game do
    context '#random_word' do
      it 'returns an appropriate word' do
        word = Game.new.random_word
        puts "For info, word is #{word}"
        expect(word.length > 4 && word.length < 13 && word[0] == word[0].downcase).to be_truthy
      end
    end
  end
end
