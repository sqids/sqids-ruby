# frozen_string_literal: true

require 'rspec'
require_relative '../lib/sqids'

upper = 1_000

describe Sqids do
  let(:sqids) { Sqids.new(min_length: Sqids::DEFAULT_ALPHABET.length) }

  it 'uniques, with padding' do
    set = Set.new

    (0...upper).each do |i|
      numbers = [i]
      id = sqids.encode(numbers)
      set.add(id)
      expect(sqids.decode(id)).to eq(numbers)
    end

    expect(set.size).to eq(upper)
  end

  it 'uniques, low ranges' do
    set = Set.new

    (0...upper).each do |i|
      numbers = [i]
      id = sqids.encode(numbers)
      set.add(id)
      expect(sqids.decode(id)).to eq(numbers)
    end

    expect(set.size).to eq(upper)
  end

  it 'uniques, high ranges' do
    set = Set.new

    (100_000_000...(100_000_000 + upper)).each do |i|
      numbers = [i]
      id = sqids.encode(numbers)
      set.add(id)
      expect(sqids.decode(id)).to eq(numbers)
    end

    expect(set.size).to eq(upper)
  end

  it 'uniques, multi' do
    set = Set.new

    (0...upper).each do |i|
      numbers = [i, i, i, i, i]
      id = sqids.encode(numbers)
      set.add(id)
      expect(sqids.decode(id)).to eq(numbers)
    end

    expect(set.size).to eq(upper)
  end
end
