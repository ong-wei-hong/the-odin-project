# frozen_string_literal: true

require 'yaml'

module Hangman
  # Game handles the sequence of events
  class Game
    def play
      initialize_game
      while @player.remaining_guesses.positive?
        puts "Remaining guesses: #{@player.remaining_guesses}\nPrevious guesses: [#{@computer.previous_guesses.join(' ')}]\nWord: #{@computer.get_word_state}\nEnter your guess: (or save to save the game)"

        guess = @player.guess

        if guess == :save
          save_file
          return
        end

        case @computer.receive(guess)
        when :repeat
          puts "\nRepeated guess!"
        when :complete
          puts "\nCongrats! You guessed the word #{@computer.word}\n\n"
          return
        when :correct
          puts "\nGood guess!"
        when :wrong
          puts "\nIncorrect" unless @player.remaining_guesses == 1
          @player.remaining_guesses -= 1
        end
      end
      puts "\nComputer wins! The word was #{@computer.word}\n\n"
    end

    def save_file
      puts "\nEnter name for save file:"
      filename = gets.chomp

      while filename.match(/\A[a-zA-Z0-9]*\z/).nil?
        puts "\nInvalid characters for filename. Please enter another name:"
        filename = gets.chomp
      end

      if File.exist?("saved/#{filename}.yml")
        puts "\nFile exists. Please confirm name for save file: (This warning will only appear once)"
        filename = gets.chomp

        while filename.match(/\A[a-zA-Z0-9]*\z/).nil?
          puts "\nInvalid characters for filename. Please enter another name:"
          filename = gets.chomp
        end
      end

      f = File.open("saved/#{filename}.yml", 'w')
      YAML.dump([@player.remaining_guesses, @computer.word, @computer.word_state, @computer.previous_guesses], f)
      f.close

      puts "\nGame saved under saved/#{filename}.yml"
    end

    def random_word
      words = []
      File.foreach('dictionary/5desk.txt') do |line|
        line = line.chomp
        words << line if line[0].downcase == line[0] && line.length < 13 && line.length > 4
      end
      words.sample
    end

    def initialize_game
      intro = "Welcome to Hangman\nEnter 1 to start a new game\nEnter 2 to resume"
      puts intro

      input = gets.chomp
      puts ''

      while input != '1' && input != '2'
        puts "\nInput not recognised\nEnter 1 to start a new game\nEnter 2 to resume"
        input = gets.chomp
        puts ''
      end

      if input == '1'
        @player = Player.new
        @computer = Computer.new(random_word)
      elsif input == '2'
        puts "Saved files found:\n\n"
        Dir.entries('saved').each { |file| puts file[0..-5] if file.length > 2 }
        puts "\nEnter filename:"

        filename = gets.chomp
        until File.exist?("saved/#{filename}.yml")
          puts "\nsaved/#{filename}.yml not found. Please select a filename from below\n\n"
          Dir.entries('saved').each { |file| puts file[0..-5] if file.length > 2 }
          puts "\nEnter filename:"
          filename = gets.chomp
        end

        saved_info = YAML.load_file("saved/#{filename}.yml")
        @player = Player.new(saved_info[0])
        @computer = Computer.new(saved_info[1], saved_info[2], saved_info[3])

        puts "saved/#{filename}.yml loaded!\n\n"
      end
    end
  end
end
