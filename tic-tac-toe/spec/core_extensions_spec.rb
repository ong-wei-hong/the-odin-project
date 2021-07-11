# frozen_string_literal: true

require 'spec_helper'

describe Array do
  context '#all_empty?' do
    it 'returns true if all elements of the Array are empty' do
      expect(['', '', ''].all_empty?).to be_truthy
    end

    it 'returns false if some of the Array elements are not empty' do
      expect(['', 1, '', Object.new, :a].all_empty?).to be_falsey
    end

    it 'returns true for an empty Array' do
      expect([].all_empty?).to be_truthy
    end
  end

  context '#all_same?' do
    it 'returns true when all elements of the Array are the same' do
      expect(%w[a a a].all_same?).to be_truthy
    end

    it 'returns false if some of the Array elements are not the same' do
      expect(['', 1, '', Object.new, :a].all_same?).to be_falsey
    end

    it 'returns true for an empty Array' do
      expect([].all_same?).to be_truthy
    end
  end

  context '#any_empty?' do
    it 'returns true when there are empty elements in the Array' do
      expect([1, '', 2].any_empty?).to be_truthy
    end

    it 'returns false when there are no empty elements in the Array' do
      expect([1, 3, 2].any_empty?).to be_falsey
    end

    it 'returns false for an empty Array' do
      expect([].any_empty?).to be_falsey
    end
  end

  context '#none_empty?' do
    it 'returns true when none of the Array elements are empty' do
      expect([1, 2, 3].none_empty?).to  be_truthy
    end

    it 'return false when one of the Array element is empty' do
      expect([1, '', 2].none_empty?).to be_falsey
    end

    it 'returns true for an empty Array' do
      expect([].none_empty?).to be_truthy
    end
  end
end
