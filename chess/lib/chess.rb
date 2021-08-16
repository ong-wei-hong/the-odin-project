# frozen_string_literal: true

require_relative 'chess/version'

module Chess
end

require_relative 'chess/piece'
Dir[File.join(__dir__, 'chess', '*.rb')].sort.each { |file| require file }
