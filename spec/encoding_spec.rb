require 'rspec'
require_relative '../lib/sqids'

describe 'Sqids' do
  it 'simple' do
    sqids = Sqids.new

    numbers = [1, 2, 3]
    id = '8QRLaD'

    expect(sqids.encode(numbers)).to eq(id)
    expect(sqids.decode(id)).to eq(numbers)
  end

  it 'different inputs' do
    sqids = Sqids.new

    numbers = [0, 0, 0, 1, 2, 3, 100, 1_000, 100_000, 1_000_000, Sqids.max_value]
    expect(sqids.decode(sqids.encode(numbers))).to eq(numbers)
  end

  it 'incremental numbers' do
    sqids = Sqids.new

    ids = {
      'bV' => [0],
      'U9' => [1],
      'g8' => [2],
      'Ez' => [3],
      'V8' => [4],
      'ul' => [5],
      'O3' => [6],
      'AF' => [7],
      'ph' => [8],
      'n8' => [9]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'incremental numbers, same index 0' do
    sqids = Sqids.new

    ids = {
      'SrIu' => [0, 0],
      'nZqE' => [0, 1],
      'tJyf' => [0, 2],
      'e86S' => [0, 3],
      'rtC7' => [0, 4],
      'sQ8R' => [0, 5],
      'uz2n' => [0, 6],
      '7Td9' => [0, 7],
      '3nWE' => [0, 8],
      'mIxM' => [0, 9]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'incremental numbers, same index 1' do
    sqids = Sqids.new

    ids = {
      'SrIu' => [0, 0],
      'nbqh' => [1, 0],
      't4yj' => [2, 0],
      'eQ6L' => [3, 0],
      'r4Cc' => [4, 0],
      'sL82' => [5, 0],
      'uo2f' => [6, 0],
      '7Zdq' => [7, 0],
      '36Wf' => [8, 0],
      'm4xT' => [9, 0]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'multi input' do
    sqids = Sqids.new

    numbers = (0..99).to_a
    output = sqids.decode(sqids.encode(numbers))
    expect(numbers).to eq(output)
  end

  it 'encoding no numbers' do
    sqids = Sqids.new
    expect(sqids.encode([])).to eq('')
  end

  it 'decoding empty string' do
    sqids = Sqids.new
    expect(sqids.decode('')).to eq([])
  end

  it 'decoding an ID with an invalid character' do
    sqids = Sqids.new
    expect(sqids.decode('*')).to eq([])
  end

  it 'decoding an invalid ID with a repeating reserved character' do
    sqids = Sqids.new
    expect(sqids.decode('fff')).to eq([])
  end

  it 'encode out-of-range numbers' do
    sqids = Sqids.new
    expect { sqids.encode([Sqids.min_value - 1]) }.to raise_error(ArgumentError)
    expect { sqids.encode([Sqids.max_value + 1]) }.to raise_error(ArgumentError)
  end
end
