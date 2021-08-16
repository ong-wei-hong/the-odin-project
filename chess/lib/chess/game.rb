# frozen_string_literal: true

require 'yaml'

module Chess
  # Game handles the flow of events
  class Game
    def play
      introduction
      initialize_game(game_type)

      loop do
        puts "\n#{@player1.full_side} turn"
        return save_game(1) if @player1.action(@board) == :save
        break if @board.winner

        puts "\n#{@player2.full_side} turn"
        return save_game(2) if @player2.action(@board) == :save
        break if @board.winner
      end

      puts "Checkmate"
      puts @board.to_s
      puts "Congrats! #{@board.winner} wins!"
    end

    private

    def game_info(i)
      saved_info = @board.save_info
      if i == 1
        player1_info = @player1.info
        player2_info = @player2.info
      elsif i == 2
        player1_info = @player2.info
        player2_info = @player1.info
      end
      [saved_info, player1_info, player2_info]
    end

    def save_game(i)
      puts "\nEnter name for save file"
      filename = gets.chomp

      while filename.match(/\A[a-zA-z0-9]*\z/).nil?
        puts "\nInvalid characters for filename\nPlease enter another name:"
        filename = gets.chomp
      end

      if File.exists?("saved/#{filename}.yml")
        puts "\nFile exists. Please confirm name for save file: (This warning will only appear once)"
        filename = gets.chomp

        while filename.match(/\A[a-zA-Z0-9]*\z/).nil?
          puts "\nInvalid characters for filename\nPlease enter another name:"
          filename = gets.chomp
        end
      end

      f = File.open("saved/#{filename}.yml", 'w')
      YAML.dump(game_info(i), f)
      f.close

      puts "\nGame saved under saved/#{filename}.yml"
    end

    def ask_color
      puts 'Enter white or black'
      option = gets.chomp
      until option.downcase == 'white' || option.downcase == 'black'
        puts "\nInput not recognised\nEnter white or black"
        option = gets
      end

      if option == 'white'
        @player1 = Player.new(:w)
        @player2 = Computer.new(:b)
      elsif option == 'black'
        @player1 = Computer.new(:w)
        @player2 = Player.new(:b)
      end
    end

    def load_player(info)
      if info[0] == :player
        Player.new(info[1])
      elsif info[0] == :computer
        Computer.new(info[1])
      end
    end

    def load_game
      puts "Saved files found:\n\n"
      Dir.entries('saved').each { |file| puts file[0..-5] if file.length > 2 }
      puts"\nEnter filename:"

      filename = gets.chomp
      until File.exists?("saved/#{filename}.yml")
        puts "\nsaved/#{filename}.yml not found. Please select a filename from below\n\n"
        Dir.entries('saved').each { |file| puts file[0..-5] if file.length > 2 }
        puts "\nEnter filename:"
        filename = gets.chomp
      end

      saved_info = YAML.load_file("saved/#{filename}.yml")
      @board = Board.new(saved_info[0])
      @player1 = load_player(saved_info[1])
      @player2 = load_player(saved_info[2])

      puts "saved/#{filename}.yml loaded\n\n"
    end

    def initialize_game(option)
      case option
      when '1'
        @board = Board.new
        ask_color
      when '2'
        @board = Board.new
        @player1 = Player.new(:w)
        @player2 = Player.new(:b)
      when '3'
        load_game
      end
    end

    def game_type
      option = gets.chomp
      until /^[1-3]$/.match(option)
        puts <<~ERROR

          Input not recognised
          Enter 1 to start a new 1 player game
          Enter 2 to start a new 2 player game
          Enter 3 to continue a saved game
        ERROR
        option = gets.chomp
      end
      option
    end

    def introduction
      puts <<~INTRO
        Welcome to chess

        Enter 1 to start a new 1 player game
        Enter 2 to start a new 2 player game
        Enter 3 to continue a saved game
      INTRO
    end
  end
end

