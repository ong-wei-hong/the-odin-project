# frozen_string_literal: true

module Chess
  # Piece handles the chess piece objects
  class Piece
    attr_accessor :type, :first_move
    attr_reader :side

    def initialize(side, type, first_move = true)
      @side = side
      @type = type
      @first_move = first_move
      @@pieces =
      {
        w:
        {
          k: "\u2654", q: "\u2655", r: "\u2656",
          b: "\u2657", n: "\u2658", p: "\u2659"
        },
        b:
        {
          k: "\u265A", q: "\u265B", r: "\u265C",
          b: "\u265D", n: "\u265E", p: "\u265F"
        }
      }
    end

    def to_s
      @@pieces[@side][@type]
    end

    def info
      [side, type, first_move]
    end
  end
end
