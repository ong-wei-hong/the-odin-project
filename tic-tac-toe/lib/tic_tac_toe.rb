# frozen_string_literal: true

require_relative 'tic_tac_toe/version'
# tic_tac_toe game
module TicTacToe
end

Dir[File.join(__dir__, 'tic_tac_toe', '*.rb')].sort.each { |file| require file }
