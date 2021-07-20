# frozen_string_literal: true

require_relative 'hangman/version'

module Hangman
end

Dir[File.join(__dir__, 'hangman', '*.rb')].sort.each { |file| require file }
