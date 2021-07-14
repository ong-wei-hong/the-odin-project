# frozen_string_literal: true

require 'spec_helper'

# the board stores the state, checks for wins/draws
module TicTacToe
  describe Board do
    context '#initialize' do
      it 'initializes the board with a grid' do
        expect { Board.new(grid: 'grid') }.to_not raise_error
      end
      it 'sets the grid with three rows by default' do
        expect(Board.new.grid.size).to eq(3)
      end
      it 'creates three things in each row by default' do
        Board.new.grid.each do |row|
          expect(row.size).to eq(3)
        end
      end
      it 'returns the grid' do
        board = Board.new(grid: 'blah')
        expect(board.grid).to eq 'blah'
      end
    end

    context '#get_cell' do
      it 'returns the cell based on the (x, y) coordinate' do
        grid = [['', '', ''], ['', '', 'something'], ['', '', '']]
        board = Board.new(grid: grid)
        expect(board.get_cell(2, 1)).to eq 'something'
      end
    end

    context '#set_cell' do
      it 'updates the value of the cell object at (x, y) coordinate' do
        Cat = Struct.new(:value)
        grid = [[Cat.new('cool'), '', ''], ['', '', ''], ['', '', '']]
        board = Board.new(grid: grid)
        board.set_cell(0, 0, 'meow')
        expect(board.get_cell(0, 0).value).to eq 'meow'
      end
    end

    TestCell = Struct.new(:value)
    let(:x_cell) { TestCell.new('X') }
    let(:y_cell) { TestCell.new('Y') }
    let (:empty) { TestCell.new }

    context '#game_over' do
      it 'returns :winner if winner? is true' do
        board = Board.new
        allow(board).to receive(:winner?) { true }
        expect(board.game_over).to eq :winner
      end

      it 'returns :draw if winner? is false and draw? is true' do
        board = Board.new
        allow(board).to receive(:winner?) { false }
        allow(board).to receive(:draw?) { true }
        expect(board.game_over).to eq :draw
      end

      it 'returns false if winner? is false and draw? is false' do
        board = Board.new
        allow(board).to receive(:winner?) { false }
        allow(board).to receive(:draw?) { false }
        expect(board.game_over).to be_falsey
      end

      it 'returns :winner when row has objects with values that are all the same' do
        grid = [
          [x_cell, x_cell, x_cell],
          [y_cell, y_cell, x_cell],
          [y_cell, y_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it 'returns :winner when column has objects with values that are all the same' do
        grid = [
          [y_cell, y_cell, empty],
          [x_cell, y_cell, x_cell],
          [x_cell, y_cell, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it 'returns :winner when diagonal had objects that are the same' do
        grid = [
          [x_cell, empty, empty],
          [y_cell, x_cell, x_cell],
          [y_cell, y_cell, x_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :winner
      end

      it 'returns :draw when all spaces on the board are taken' do
        grid = [
          [x_cell, y_cell, x_cell],
          [y_cell, x_cell, y_cell],
          [y_cell, x_cell, y_cell]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to eq :draw
      end

      it 'returns false when there is no winner or draw' do
        grid = [
          [x_cell, empty, empty],
          [y_cell, empty, empty],
          [y_cell, empty, empty]
        ]
        board = Board.new(grid: grid)
        expect(board.game_over).to be_falsey
      end
    end
  end
end