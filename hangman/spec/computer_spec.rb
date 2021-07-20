# frozen_string_literal: true

require 'spec_helper'

module Hangman
  describe Computer do
    context '#get_word_state' do
      it 'returns the correct word_state' do
        computer = Computer.new('sample')
        expect(computer.get_word_state).to eq '_ _ _ _ _ _'
      end
    end

    context '#receive' do
      it 'amends word state when computer.receive a correct char' do
        computer = Computer.new('sample')
        computer.receive('s')
        expect(computer.word_state).to eq %w[s _ _ _ _ _]
      end

      it 'works with multiple same characters in word' do
        computer = Computer.new('similar')
        computer.receive('i')
        expect(computer.word_state).to eq %w[_ i _ i _ _ _]
      end

      it 'returns :repeat when computer.receives a duplicate character' do
        computer = Computer.new('sample')
        computer.receive('q')
        expect(computer.receive('q')).to eq :repeat
      end

      it 'returns :complete when computer.recieves finishes the word' do
        computer = Computer.new('sssss')
        expect(computer.receive('s')).to eq :complete
      end

      it 'returns :correct when computer.receives a character in word' do
        computer = Computer.new('sample')
        expect(computer.receive('s')).to eq :correct
      end

      it 'returns :wrong when computer.receives a character not in word' do
        computer = Computer.new('sample')
        expect(computer.receive('q')).to eq :wrong
      end
    end
  end
end
