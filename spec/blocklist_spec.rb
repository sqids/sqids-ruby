# frozen_string_literal: true

require 'rspec'
require 'set'
require_relative '../lib/sqids'

describe Sqids do
  it 'uses default blocklist if no custom blocklist is provided' do
    sqids = Sqids.new

    expect(sqids.decode('aho1e')).to eq([4_572_721])
    expect(sqids.encode([4_572_721])).to eq('JExTR')
  end

  it 'does not use any blocklist if an empty blocklist is provided' do
    sqids = Sqids.new(blocklist: Set.new([]))

    expect(sqids.decode('aho1e')).to eq([4_572_721])
    expect(sqids.encode([4_572_721])).to eq('aho1e')
  end

  it 'uses provided blocklist if non-empty blocklist is provided' do
    sqids = Sqids.new(blocklist: Set.new(['ArUO']))

    expect(sqids.decode('aho1e')).to eq([4_572_721])
    expect(sqids.encode([4_572_721])).to eq('aho1e')

    expect(sqids.decode('ArUO')).to eq([100_000])
    expect(sqids.encode([100_000])).to eq('QyG4')
    expect(sqids.decode('QyG4')).to eq([100_000])
  end

  it 'uses blocklist to prevent certain encodings' do
    sqids = Sqids.new(blocklist: Set.new(%w[JSwXFaosAN OCjV9JK64o rBHf 79SM 7tE6]))

    expect(sqids.encode([1_000_000, 2_000_000])).to eq('1aYeB7bRUt')
    expect(sqids.decode('1aYeB7bRUt')).to eq([1_000_000, 2_000_000])
  end

  it 'can decode blocklist words' do
    sqids = Sqids.new(blocklist: Set.new(%w[86Rf07 se8ojk ARsz1p Q8AI49 5sQRZO]))

    expect(sqids.decode('86Rf07')).to eq([1, 2, 3])
    expect(sqids.decode('se8ojk')).to eq([1, 2, 3])
    expect(sqids.decode('ARsz1p')).to eq([1, 2, 3])
    expect(sqids.decode('Q8AI49')).to eq([1, 2, 3])
    expect(sqids.decode('5sQRZO')).to eq([1, 2, 3])
  end

  it 'matches against a short blocklist word' do
    sqids = Sqids.new(blocklist: Set.new(['pnd']))

    expect(sqids.decode(sqids.encode([1_000]))).to eq([1_000])
  end

  it 'blocklist filtering in constructor' do
    # lowercase blocklist in only-uppercase alphabet
    sqids = Sqids.new(alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', blocklist: Set.new(['sxnzkl']))

    id = sqids.encode([1, 2, 3])
    numbers = sqids.decode(id)

    expect(id).to eq('IBSHOZ') # without blocklist, would've been "SXNZKL"
    expect(numbers).to eq([1, 2, 3])
  end

  it 'max encoding attempts' do
    alphabet = 'abc'
    min_length = 3
    blocklist = Set.new(%w[cab abc bca])

    sqids = Sqids.new(alphabet: alphabet, min_length: min_length, blocklist: blocklist)

    expect(min_length).to eq(alphabet.length)
    expect(min_length).to eq(blocklist.size)

    expect do
      sqids.encode([0])
    end.to raise_error(ArgumentError)
  end
end
