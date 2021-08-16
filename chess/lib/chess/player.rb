# frozen_string_literal: true

module Chess
  # Player handle player feedback
  class Player
    def initialize(side)
      @side = side
    end

    def action(board)
      puts board.to_s

      location_and_moves = valid_location_with_moves(board)

      return :save if location_and_moves == :save

      selected_location = location_and_moves[0]
      moves = location_and_moves[1]

      puts board.to_s(selected_location, moves)

      selected_move = valid_move(moves)
      board.move(selected_location, selected_move)

      if selected_move.is_a? Array
        promote_pawn(board, selected_move) if board.pawn_promotion?(selected_move)
      end

      puts "Check" if board.check?(@side)
    end

    def full_side
      if @side == :w
        'White'
      elsif @side == :b
        'Black'
      end
    end

    def info
      [:player, @side]
    end

    private

    def promote_pawn(board, location)
      board.promote_pawn(location, valid_type)
    end

    def valid_type
      puts 'Promote pawn to? (queen, bishop, knight, rook)'
      type = ask_type
      type[0] == 'k' ? 'n' : type[0]
    end

    def ask_type
      type = gets.chomp
      until %w[queen bishop knight rook].include?(type)
        puts "\nInput not recognised\nPromote pawn to? (queen, bishop, knight, rook)"
        type = gets.chomp
      end
      type
    end

    def ask_move
      move = gets.chomp
      until /^[A-Ha-h][1-8]$/.match(move)
        return :en_passant if move.downcase == 'en-passant'
        return :castling if move.downcase == 'castling'

        puts "\nInput not recognised\nSelect move (in the format [letter][number] or command)"
        move = gets.chomp
      end
      [8 - move[1].to_i, move[0].downcase.ord - 97]
    end

    def valid_move(moves)
      puts 'Select move (in the format [letter][number])'
      move = ask_move

      unless moves.include?(move)
        puts "\nInvalid move"
        move = valid_move(moves)
      end
      move
    end

    def valid_location_with_moves(board)
      puts 'Select piece (in the format [letter][number])'
      location_with_moves = nil
      location = ask_location

      return :save if location == :save

      piece = board.at(location)
      unless Piece === piece && piece.side == @side
        puts "\nInvalid piece selected"
        return location_with_moves = valid_location_with_moves(board)
      end

      moves = board.moves(location)
      moves << :en_passant if board.en_passant?(location)
      moves << :castling if board.castling?(location)

      if moves.empty?
        puts "\nSelected piece is unable to move"
        return location_with_moves = valid_location_with_moves(board)
      end

      [location, moves]
    end

    def ask_location
      location = gets.chomp
      until /^[A-Ha-h][1-8]$/.match(location)
        return :save if location == 'save'
        puts "\nInput not recognised\nSelect piece (in the format [letter][number])"
        location = gets.chomp
      end
      [8 - location[1].to_i, location[0].downcase.ord - 97]
    end
  end
end
