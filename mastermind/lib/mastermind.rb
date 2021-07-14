# frozen_string_literal: true

require_relative 'mastermind/version'

module Mastermind
end

Dir[File.join(__dir__, 'mastermind', '*.rb')].sort.each { |file| require file }
