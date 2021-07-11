# frozen_string_literal: true

require_relative '../lib/tic_tac_toe'

puts 'Welcome to tic tac toe'
bob = TicTacToe::Player.new({ color: 'X', name: 'bob' })
frank = TicTacToe::Player.new({ color: 'O', name: 'frank' })
players = [bob, frank]
TicTacToe::Game.new(players).play
