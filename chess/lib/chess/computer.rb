# frozen_string_literal: true

module Chess
  # Computer handles the computer actions
  class Computer
    def initialize(side)
      @side = side
    end

    def action(board)
      puts board.to_s
      location_and_move = select_random_location_and_move(board)

      location = location_and_move[0]
      move = location_and_move[1]

      board.move(location, move)

      puts "Computer moves #{chessify(location)} #{chessify(move)}"

      if move.is_a?(Array) && board.pawn_promotion?(move)
        type = random_type
        board.promote_pawn(move, type)
        puts "Computer promotes pawn to #{fullname(type)}"
      end

      puts "Check" if board.check?(@side)
    end

    def info
      [:computer, @side]
    end

    def full_side
      if @side == :w
        'White'
      elsif @side == :b
        'Black'
      end
    end

    private

    def random_type
      %w[r n b q].sample
    end

    def fullname(type)
      case type
      when 'r'
        'rook'
      when 'n'
        'knight'
      when 'b'
        'bishop'
      when 'q'
        'queen'
      end
    end

    def select_random_location_and_move(board)
      pieces = board.white_pieces
      pieces = board.black_pieces if @side == :b


      location = []
      moves = []
      while moves.empty?
        location = board.find_piece_location(pieces.sample)
        moves = board.moves(location)
        moves << :en_passant if board.en_passant?(location)
        moves << :castling if board.castling?(location)
      end
      [location, moves.sample]
    end

    def chessify(location)
      return 'en-passant' if location == :en_passant
      return 'castling' if location == :castling

      ans = (location[1] + 65).chr
      ans += (8 - location[0]).to_s
      ans
    end
  end
end
