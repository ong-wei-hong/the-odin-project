# frozen_string_literal: true

require 'spec_helper'

module Mastermind
  describe Guesser do
    context '#initialize' do
      it 'check if possible_guesses length is correct' do
        guesser = Guesser.new(true)
        expect(Guesser.possible_guesses.length).to eq 1296
      end

      it 'check if the first element of possible_guesses is "1111"' do
        guesser = Guesser.new(true)
        expect(Guesser.possible_guesses.first).to eq '1111'
      end

      it 'check if the last element of possible_guesses is "6666"' do
        guesser = Guesser.new(true)
        expect(Guesser.possible_guesses.last).to eq '6666'
      end

      it 'checks if possible_guesses wraps properly' do
        guesser = Guesser.new(true)
        expect(Guesser.possible_guesses[6]).to eq '1121' # not '1117' or '1120'
      end
    end
  end
end
