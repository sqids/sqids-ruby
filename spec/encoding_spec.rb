# frozen_string_literal: true

require 'rspec'
require_relative '../lib/sqids'

describe 'Sqids' do
  it 'simple' do
    sqids = Sqids.new

    numbers = [1, 2, 3]
    id = '86Rf07'

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
      'bM' => [0],
      'Uk' => [1],
      'gb' => [2],
      'Ef' => [3],
      'Vq' => [4],
      'uw' => [5],
      'OI' => [6],
      'AX' => [7],
      'p6' => [8],
      'nJ' => [9]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'incremental numbers, same index 0' do
    sqids = Sqids.new

    ids = {
      'SvIz' => [0, 0],
      'n3qa' => [0, 1],
      'tryF' => [0, 2],
      'eg6q' => [0, 3],
      'rSCF' => [0, 4],
      'sR8x' => [0, 5],
      'uY2M' => [0, 6],
      '74dI' => [0, 7],
      '30WX' => [0, 8],
      'moxr' => [0, 9]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'incremental numbers, same index 1' do
    sqids = Sqids.new

    ids = {
      'SvIz' => [0, 0],
      'nWqP' => [1, 0],
      'tSyw' => [2, 0],
      'eX68' => [3, 0],
      'rxCY' => [4, 0],
      'sV8a' => [5, 0],
      'uf2K' => [6, 0],
      '7Cdk' => [7, 0],
      '3aWP' => [8, 0],
      'm2xn' => [9, 0]
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

  it 'encoding with float' do
    sqids = Sqids.new
    float = 3.14159265
    encoded_float = sqids.encode([float])
    encoded_int = sqids.encode([float.to_i])
    expect(encoded_float).to eq(encoded_int)
  end

  it 'decoding empty string' do
    sqids = Sqids.new
    expect(sqids.decode('')).to eq([])
  end

  it 'decoding an ID with an invalid character' do
    sqids = Sqids.new
    expect(sqids.decode('*')).to eq([])
  end

  it 'encode out-of-range numbers' do
    sqids = Sqids.new
    expect { sqids.encode([-1]) }.to raise_error(ArgumentError)
    expect { sqids.encode([Sqids.max_value + 1]) }.to raise_error(ArgumentError)
  end
end
