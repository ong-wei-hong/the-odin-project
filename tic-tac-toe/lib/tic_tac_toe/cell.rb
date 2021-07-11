# frozen_string_literal: true

module TicTacToe
  # a cell stores the value of a box
  class Cell
    attr_accessor :value

    def initialize(value = '')
      @value = value
    end
  end
end
