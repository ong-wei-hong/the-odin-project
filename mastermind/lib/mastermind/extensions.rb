# frozen_string_literal: true

# some game specific methods
class String
  def code_valid?
    split('').all? { |e| e.to_i.to_s == e && e.to_i <= 6 && e.to_i >= 1 } && length == 4
  end
end
