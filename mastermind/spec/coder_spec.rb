# frozen_string_literal: true

require 'spec_helper'

module Mastermind
  describe Coder do
    context 'feedback' do
      it 'returns "OOOO" when code == guess' do
        expect(Coder.feedback('1111', '1111')).to eq 'OOOO'
      end

      it 'returns "NNNN" when guess has the same numbers but different positions as code' do
        expect(Coder.feedback('1234', '4321')).to eq 'NNNN'
      end

      it 'returns "XXXX" when guess has no similar numbers as code' do
        expect(Coder.feedback('1111', '2222')).to eq 'XXXX'
      end

      it 'returns "NXXX" when appropriate (checking for double counting of "N")' do
        expect(Coder.feedback('1222', '3111')).to eq 'NXXX'
      end

      it 'returns "NXXX" when appropriate (another way of checking "N" computes properly' do
        expect(Coder.feedback('1112', '3331')).to eq 'NXXX'
      end

      it 'returns "OXXX" when appropriate (checking for undesired counting of "N" when character has been used for "O" already' do
        expect(Coder.feedback('1222', '1111')).to eq 'OXXX'
      end
    end
  end
end
