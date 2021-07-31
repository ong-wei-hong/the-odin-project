# frozen_string_literal: true

require_relative 'connect_four/version'

module ConnectFour
end

Dir[File.join(__dir__, 'connect_four', '*.rb')].sort.each { |file| require file }
