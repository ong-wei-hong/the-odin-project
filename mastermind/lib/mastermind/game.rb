# frozen_string_literal: true

module Mastermind
  # Game handles the sequence of events
  class Game
    def play
      intro = "Welcome to 1 player Mastermind\nIn this game, you choose to be a guesser or a coder.\nA coder makes a code with 4 numbers from 1 to 6 while the guesser gets 12 attempts to guess it\nAfter each guess the coder gives 4 letters of feedback:\nO means 1 number is correct and in the correct place\nN means 1 number is correct and in the wrong place\nX means 1 number is wrong"
      puts intro
      player_info
      i = 1
      while i <= 12
        puts "Guess #{i}"
        guess = @players[0].guess
        if @players[1].feedback(guess)
          puts "#{@players[0].name} guessed the code #{@players[1].role.code}. #{@players[0].name} wins!"
          return
        end
        i += 1
      end
      puts "#{@players[0].name} did not guess the code #{@players[1].role.code}. #{@players[1].name} wins!"
    end

    private

    def generate_code
      4.times.map { rand(1...7) }.join
    end

    def ask_code
      puts 'Enter your code: (The computer will not be able to see it)'
      code = gets.chomp
      until code.code_valid?
        puts "#{code} is invalid. Enter another code: (code must be 4 digits long with each digit being from 1 to 6)"
        code = gets.chomp
      end
      code
    end

    def player_info
      puts 'Enter name:'
      name = gets.chomp
      puts 'Enter role: (g for guesser or c for coder)'
      role = gets.chomp
      while role != 'g' && role != 'c'
        puts 'Input not recognised. Enter role: (g for guesser or c for coder)'
        role = gets.chomp
      end
      if role == 'g'
        code = generate_code
        @players = [
          Player.new(name, Guesser.new),
          Computer.new(Coder.new(code))
        ]
      else
        code = ask_code
        @players = [
          Computer.new(Guesser.new(true)),
          Player.new(name, Coder.new(code))
        ]
      end
    end
  end
end
