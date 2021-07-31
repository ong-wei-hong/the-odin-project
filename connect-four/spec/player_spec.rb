# frozen_string_literal: true

require_relative 'spec_helper'

module ConnectFour
  # Player handles the player's actions
  describe Player do
    let(:board) { double('board') }
    subject(:player) { Player.new('X', Board.new) }

    describe '#ask' do
      context 'when valid input is recevied' do
        before do
          allow(player).to receive(:puts)
          allow(player).to receive(:gets).and_return('1')
          allow(board).to receive(:invalid).with('1').and_return(false)
        end

        it 'returns the valid input as integer' do
          expect(player.ask).to equal 1
        end
      end

      context 'when invalid input is received twice and then valid input is received' do
        before do
          allow(player).to receive(:puts).exactly(3).times
          allow(player).to receive(:gets).and_return('0', 'a', '1')
          allow(board).to receive(:invalid).with('0').and_return(true)
          allow(board).to receive(:invalid).with('a').and_return(true)
        end

        it 'asks for valid input twice' do
          expect(player).to receive(:puts).with("\ninvalid input\nplease enter a number from 1 to 7 which column is not full").twice
          player.ask
        end

        it 'returns the valid input as integer' do
          expect(player.ask).to equal 1
        end
      end
    end
  end
end
