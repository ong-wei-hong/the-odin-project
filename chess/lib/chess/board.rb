# frozen_string_literal: true

module Chess
  # Board handles the board state
  class Board
    attr_reader :white_pieces, :black_pieces

    def initialize(info = [])
      @en_passant = nil
      initialize_board(info)
      initialize_moves
    end

    def to_s(selected_location = [], moves = [])
      to_print = "  abcdefgh\n"
      @board.each_with_index do |row, i|
        to_print += "#{8 - i} "
        row.each_with_index do |e, j|
          to_print += add_color(e, i, j, selected_location, moves)
        end
        to_print += "\n"
      end
      to_print
    end

    def at(arr)
      @board[arr[0]][arr[1]]
    end

    def winner
      black = :black
      white = :white

      black = nil if @white_pieces.any? { |e| e.type == :k }
      white = nil if @black_pieces.any? { |e| e.type == :k }

      black || white
    end

    def moves(location)
      piece = @board[location[0]][location[1]]
      send(@moves[piece.type], piece.side, location)
    end

    def move(start_location, move)
      if move == :en_passant
        handle_en_passant(start_location)
        @en_passant = nil
      elsif move == :castling
        rook = @board[start_location[0]][start_location[1]]
        king_location = find_king(rook.side)
        king = @board[king_location[0]][king_location[1]]

        x = 1
        x = -1 if start_location[1] < king_location[1]

        new_king_location = [king_location[0], king_location[1] + 2 * x]
        @board[new_king_location[0]][new_king_location[1]] = @board[king_location[0]][king_location[1]]
        @board[king_location[0]][king_location[1]] = ' '

        @board[new_king_location[0]][new_king_location[1] - x] = @board[start_location[0]][start_location[1]]
        @board[start_location[0]][start_location[1]] = ' '

        king.first_move = false
        rook.first_move = false
      else
        end_piece = @board[move[0]][move[1]]
        remove(end_piece) unless move == ' '

        @board[move[0]][move[1]] = @board[start_location[0]][start_location[1]]
        @board[start_location[0]][start_location[1]] = ' '
        post_move(start_location, move)
      end
    end

    def check?(side)
      pieces = @black_pieces
      pieces = @white_pieces if side == :w

      @board.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          if pieces.include?(piece)
            moves = moves([i, j])
            moves.each do |pos|
              target = @board[pos[0]][pos[1]]
              return true if target != ' ' && target.type == :k
            end
          end
        end
      end

      false
    end

    def en_passant?(location)
      return false unless @board[location[0]][location[1]].type == :p

      left_location = [location[0], location[1] - 1]
      right_location = [location[0], location[1] + 1]
      return :left if valid_move?(left_location) && @board[left_location[0]][left_location[1]] == @en_passant

      return :right if valid_move?(right_location) && @board[right_location[0]][right_location[1]] == @en_passant

      false
    end

    def castling?(location)
      rook = @board[location[0]][location[1]]
      king_location = find_king(rook.side)
      king = @board[king_location[0]][king_location[1]]

      return false if rook.type != :r || !rook.first_move || !king.first_move

      king_movement = 1
      king_movement = -1 if location[1] < king_location[1]
      king_movements = []

      3.times do |i|
        king_movements << [king_location[0], king_location[1] + i * king_movement]
      end

      return false if enemy_attack?(rook.side, king_movements)

      squares_between = []
      next_location = [king_location[0], king_location[1] + king_movement]

      until next_location == location
        squares_between << next_location
        next_location = [next_location[0], next_location[1] + king_movement]
      end

      return true if all_empty?(squares_between)
      false
    end

    def find_piece_location(piece)
      @board.each_with_index do |row, i|
        row.each_with_index do |curr, j|
          return [i, j] if curr == piece
        end
      end
      nil
    end

    def pawn_promotion?(end_location)
      (end_location[0].zero? || end_location[0] == 7) && @board[end_location[0]][end_location[1]].type == :p
    end

    def promote_pawn(end_location, type)
      @board[end_location[0]][end_location[1]].type = type.to_sym
    end

    def save_info
      white = []
      black = []
      @board.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          if piece != ' ' && piece.side == :b
            black.push([i, j, piece.info])
          elsif piece != ' ' && piece.side == :w
            white.push([i, j, piece.info])
          end
        end
      end
      [white, black, en_passant_location]
    end

    private

    def en_passant_location
      if @en_passant
        @board.each_with_index do |row, i|
          row.each_with_index do |piece, j|
            return [i, j] if piece == @en_passant
          end
        end
      end
      nil
    end

    def all_empty?(squares_between)
      squares_between.each do |e|
        return false unless @board[e[0]][e[1]] == ' '
      end
      true
    end

    def enemy_attack?(side, king_movements)
      pieces = @white_pieces
      pieces = @black_pieces if side == :w

      @board.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          if pieces.include?(piece)
            moves = moves([i, j])
            moves.each do |move|
              return true if king_movements.include?(move)
            end
          end
        end
      end
      false
    end

    def find_king(side)
      @board.each_with_index do |row, i|
        row.each_with_index do |piece, j|
          return [i, j] if piece != ' ' && piece.side == side && piece.type == :k
        end
      end
    end

    def handle_en_passant(start_location)
      x = 1
      x = -1 if @board[start_location[0]][start_location[1]].side == :w

      y = 1
      y = -1 if en_passant?(start_location) == :left

      @board[start_location[0] + x][start_location[1] + y] = @board[start_location[0]][start_location[1]]

      @board[start_location[0]][start_location[1]] = ' '

      @board[start_location[0]][start_location[1] + y] = ' '
      remove(@board[start_location[0][start_location[1] + y]])
    end

    def post_move(start_location, end_location)
      @board[end_location[0]][end_location[1]].first_move = false

      en_passant_helper(start_location, end_location)
    end

    def en_passant_helper(start_location, end_location)
      @en_passant = false

      piece = @board[end_location[0]][end_location[1]]
      @en_passant = piece if piece.type == :p && (end_location[0] - start_location[0]).abs == 2
    end

    def remove(piece)
      @white_pieces.delete(piece)
      @black_pieces.delete(piece)
    end

    def symbol(e, i, j, moves)
      if moves.include?([i, j])
        "\e[31m#{e == ' ' ? '.' : e}\e[0m"
      else
        e.to_s
      end
    end

    def add_color(e, i, j, selected_location, moves)
      if selected_location == [i, j]
        "\e[42m#{e}\e[0m"
      elsif (i + j).even?
        "\e[46m#{symbol(e, i, j, moves)}\e[0m"
      else
        symbol(e, i, j, moves)
      end
    end

    def valid_move?(move)
      move[0] >= 0 && move[0] < 8 && move[1] >= 0 && move[1] < 8
    end

    def move_at_location(side, next_move)
      return :invalid unless valid_move?(next_move)

      obj = @board[next_move[0]][next_move[1]]

      return :valid if obj == ' '
      return :invalid if obj.side == side
      return :capture if obj.side != side
    end

    def continuous_movement(side, location, movement)
      moves = []
      movement.each do |move|
        next_move = [location[0] + move[0], location[1] + move[1]]
        move_type = move_at_location(side, next_move)
        while move_type == :valid
          moves.push(next_move)
          next_move = [next_move[0] + move[0], next_move[1] + move[1]]
          move_type = move_at_location(side, next_move)
        end
        moves.push(next_move) if move_type == :capture
      end
      moves
    end

    def single_movement(side, location, movement)
      moves = []
      movement.each do |move|
        next_move = [location[0] + move[0], location[1] + move[1]]
        moves.push(next_move) unless move_at_location(side, next_move) == :invalid
      end
      moves
    end

    def king(side, location)
      single_movement(side, location, [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]])
    end

    def pawn(side, location)
      x = 1
      x = -1 if side == :w

      moves = []
      next_move = [location[0] + x, location[1]]
      moves.push(next_move) if move_at_location(side, next_move) == :valid

      next_move = [location[0] + x + x, location[1]]
      moves.push(next_move) if @board[location[0]][location[1]].first_move && move_at_location(side, next_move) == :valid && @board[location[0] + x][location[1]] == ' '

      [[x, 1], [x, -1]].each do |move|
        next_move = [location[0] + move[0], location[1] + move[1]]
        moves.push(next_move) if move_at_location(side, next_move) == :capture
      end

      moves
    end

    def knight(side, location)
      single_movement(side, location, [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]])
    end

    def queen(side, location)
      bishop(side, location) + rook(side, location)
    end

    def bishop(side, location)
      continuous_movement(side, location, [[-1, -1], [-1, 1], [1, -1], [1, 1]])
    end

    def rook(side, location)
      continuous_movement(side, location, [[-1, 0], [0, -1], [0, 1], [1, 0]])
    end

    def initialize_moves
      @moves = { r: :rook, b: :bishop, q: :queen, n: :knight, p: :pawn, k: :king }
    end

    def initialize_white_pieces
      @white_pieces =
        [
          Piece.new(:w, :p), Piece.new(:w, :p),
          Piece.new(:w, :p), Piece.new(:w, :p),
          Piece.new(:w, :p), Piece.new(:w, :p),
          Piece.new(:w, :p), Piece.new(:w, :p),
          Piece.new(:w, :r), Piece.new(:w, :n),
          Piece.new(:w, :b), Piece.new(:w, :q),
          Piece.new(:w, :k), Piece.new(:w, :b),
          Piece.new(:w, :n), Piece.new(:w, :r)
        ]
    end

    def initialize_black_pieces
      @black_pieces =
        [
          Piece.new(:b, :r), Piece.new(:b, :n),
          Piece.new(:b, :b), Piece.new(:b, :q),
          Piece.new(:b, :k), Piece.new(:b, :b),
          Piece.new(:b, :n), Piece.new(:b, :r),
          Piece.new(:b, :p), Piece.new(:b, :p),
          Piece.new(:b, :p), Piece.new(:b, :p),
          Piece.new(:b, :p), Piece.new(:b, :p),
          Piece.new(:b, :p), Piece.new(:b, :p)
        ]
    end

    def initialize_board(info)
      if info.empty?
        initialize_white_pieces
        initialize_black_pieces
        @board =
          [
            [
              @black_pieces[0], @black_pieces[1],
              @black_pieces[2], @black_pieces[3],
              @black_pieces[4], @black_pieces[5],
              @black_pieces[6], @black_pieces[7]
            ],
            [
              @black_pieces[8], @black_pieces[9],
              @black_pieces[10], @black_pieces[11],
              @black_pieces[12], @black_pieces[13],
              @black_pieces[14], @black_pieces[15]
            ],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
            [
              @white_pieces[0], @white_pieces[1],
              @white_pieces[2], @white_pieces[3],
              @white_pieces[4], @white_pieces[5],
              @white_pieces[6], @white_pieces[7]
            ],
            [
              @white_pieces[8], @white_pieces[9],
              @white_pieces[10], @white_pieces[11],
              @white_pieces[12], @white_pieces[13],
              @white_pieces[14], @white_pieces[15]
            ]
          ]
      else
        @board = Array.new(8) { Array.new(8) { ' ' } }
        @white_pieces = load_pieces(info[0])
        @black_pieces = load_pieces(info[1])
        if info[2]
          @en_passant = @board[info[2][0]][info[2][1]]
        end
      end
    end

    def load_pieces(info)
      arr = []
      info.each do |e|
        arr.push(Piece.new(e[2][0], e[2][1], e[2][2]))
        @board[e[0]][e[1]] = arr[-1]
      end
      arr
    end
  end
end

