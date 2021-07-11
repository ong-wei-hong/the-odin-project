# frozen_string_literal: true

# additional array methods
class Array
  def all_empty?
    all? { |e| e.to_s.empty? }
  end

  def all_same?
    all? { |e| e == self[0] }
  end

  def any_empty?
    any? { |e| e.to_s.empty? }
  end

  def none_empty?
    !any_empty?
  end
end
