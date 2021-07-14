# frozen_string_literal: true

require 'spec_helper'

describe String do
  context '#code_valid?' do
    it 'accepts code of length 4 with digits from 1 to 6' do
      expect('1246'.code_valid?).to be_truthy
    end

    it 'rejects code smaller than length 4' do
      expect('123'.code_valid?).to be_falsey
    end

    it 'rejects code larger than length 4' do
      expect('12345'.code_valid?).to be_falsey
    end

    it 'rejects code with digits lower than 1' do
      expect('0123'.code_valid?).to be_falsey
    end

    it 'rejects code wit digits higher than 6' do
      expect('7123'.code_valid?).to be_falsey
    end

    it 'rejects code with non-digits' do
      expect('a123'.code_valid?).to be_falsey
    end
  end
end
