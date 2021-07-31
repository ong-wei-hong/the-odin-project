# frozen_string_literal: true

require_relative 'spec_helper'

module ConnectFour
  # Board handles the state of the board
  describe Board do
    subject(:board) { described_class.new }
    describe '#display' do
      context 'empty board' do
        it 'returns an empty board' do
          correct_board =
            "\n"\
            "| . | . | . | . | . | . | . | \n"\
            "| . | . | . | . | . | . | . | \n"\
            "| . | . | . | . | . | . | . | \n"\
            "| . | . | . | . | . | . | . | \n"\
            "| . | . | . | . | . | . | . | \n"\
            "| . | . | . | . | . | . | . | \n"\
            '  1   2   3   4   5   6   7'
          expect(board.display).to eq correct_board
        end
      end

      context 'board with some pieces' do
        it 'returns the correct board' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[O X O X O X O],
              %w[X X X X X X X],
              %w[O O O O O O O],
              %w[O O O O X X X],
              %w[O O X X O O X]
            ]
          )
          correct_board =
            "\n"\
            "| . | . | . | . | . | . | . | \n"\
            "| O | X | O | X | O | X | O | \n"\
            "| X | X | X | X | X | X | X | \n"\
            "| O | O | O | O | O | O | O | \n"\
            "| O | O | O | O | X | X | X | \n"\
            "| O | O | X | X | O | O | X | \n"\
            '  1   2   3   4   5   6   7'
          expect(board.display).to eq correct_board
        end
      end
    end

    describe '#invalid(pos)' do
      context 'valid pos' do
        it 'returns false for valid pos' do
          expect(board.invalid('3')).to be_falsey
        end
      end

      context 'invalid pos' do
        it 'returns true for input below 1' do
          expect(board.invalid('0')).to be_truthy
        end

        it 'returns true for input above 7' do
          expect(board.invalid('8')).to be_truthy
        end

        it 'returns true for alphabetic inputs' do
          expect(board.invalid('a')).to be_truthy
        end

        it 'returns true for symbols' do
          expect(board.invalid('!')).to be_truthy
        end

        it 'returns true for empty inputs' do
          expect(board.invalid('')).to be_truthy
        end
      end

      context 'full row' do
        before do
          board.instance_variable_set(
            :@board,
            [
              %w[. X X X X X X],
              %w[X X X X X X X],
              %w[X X X X X X X],
              %w[X X X X X X X],
              %w[X X X X X X X],
              %w[X X X X X X X]
            ]
          )
        end

        it 'returns true for full rows' do
          expect(board.invalid('2')).to be_truthy
        end

        it 'returns false for not full rows' do
          expect(board.invalid('1')).to be_falsey
        end
      end
    end

    describe '#drop' do
      context 'drops to the bottom of column' do
        it 'changes the bottom element' do
          expect { board.drop('X', 1) }.to change { (board.instance_variable_get(:@board))[5][0] }.from('.').to('X')
        end
      end

      context 'drops on top of pre-existing piece' do
        before do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. X . . . . .]
            ]
          )
        end

        it 'does not replace other pieces' do
          expect { board.drop('O', 2) }.not_to(change { (board.instance_variable_get(:@board))[5][1] })
        end

        it 'changes the element above it' do
          expect { board.drop('O', 2) }.to(change { (board.instance_variable_get(:@board))[4][1] }.from('.').to('O'))
        end
      end

      context 'blank board' do
        it 'returns false (does not win)' do
          expect(board.drop('X', 1)).to equal false
        end
      end

      context 'horizontal wins' do
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. X X X . . .]
            ]
          )
          expect(board.drop('X', 1)).to equal true
        end
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[X . X X . . .]
            ]
          )
          expect(board.drop('X', 2)).to equal true
        end
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[X X . X . . .]
            ]
          )
          expect(board.drop('X', 3)).to equal true
        end
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[X X X . . . .]
            ]
          )
          expect(board.drop('X', 4)).to equal true
        end
      end

      context 'vertical wins' do
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . . X . . .],
              %w[. . . X . . .]
            ]
          )
          expect(board.drop('X', 4)).to equal true
        end
      end

      context 'diagonal1 wins' do
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . X O . . .],
              %w[. X O O . . .],
              %w[. O O O . . .]
            ]
          )
          expect(board.drop('X', 1)).to equal true
        end

        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . X O . . .],
              %w[. . O O . . .],
              %w[X O O O . . .]
            ]
          )
          expect(board.drop('X', 2)).to equal true
        end

        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . . O . . .],
              %w[. X O O . . .],
              %w[X O O O . . .]
            ]
          )
          expect(board.drop('X', 3)).to equal true
        end

        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . X O . . .],
              %w[. X O O . . .],
              %w[X O O O . . .]
            ]
          )
          expect(board.drop('X', 4)).to equal true
        end
      end

      context 'diagonal2 wins' do
        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . . O X . .],
              %w[. . . O O X .],
              %w[. . . O O O .]
            ]
          )
          expect(board.drop('X', 7)).to equal true
        end

        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . . O X . .],
              %w[. . . O O . .],
              %w[. . . O O O X]
            ]
          )
          expect(board.drop('X', 6)).to equal true
        end

        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . X . . .],
              %w[. . . O . . .],
              %w[. . . O O X .],
              %w[. . . O O O X]
            ]
          )
          expect(board.drop('X', 5)).to equal true
        end

        it 'wins the game' do
          board.instance_variable_set(
            :@board,
            [
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . . . . .],
              %w[. . . O X . .],
              %w[. . . O O X .],
              %w[. . . O O O X]
            ]
          )
          expect(board.drop('X', 4)).to equal true
        end
      end
    end
  end
end
