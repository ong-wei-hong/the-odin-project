# frozen_string_literal: true

module Mastermind
  VERSION = '0.1.0'
end

Dir[File.join(__dir__, 'tic_tac_toe', '*.rb')].sort.each { |file| require file }
