# frozen_string_literal: true

require_relative '../caesar_cipher'

context 'caesar_cipher' do
  it 'works with lowercase letters' do
    expect(caesar_cipher('abcdefghijklmnopqrstuvwxyz', 5)).to eq 'fghijklmnopqrstuvwxyzabcde'
  end

  it 'works with uppercase letters' do
    expect(caesar_cipher('ABCDEFGHIJKLMNOPQRSTUVWXYZ', 13)).to eq 'NOPQRSTUVWXYZABCDEFGHIJKLM'
  end

  it 'maintains non-alphabetic characters' do
    expect(caesar_cipher('a A 1 !', 5)).to eq 'f F 1 !'
  end

  it 'works with negative shifting' do
    expect(caesar_cipher('abc', -5)).to eq 'vwx'
  end

  it 'works with shifting over 26' do
    expect(caesar_cipher('abc', 31)).to eq 'fgh'
  end
end
