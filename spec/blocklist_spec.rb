# frozen_string_literal: true

require 'rspec'
require 'set'
require_relative '../lib/sqids'

describe Sqids do
  it 'uses default blocklist if no custom blocklist is provided' do
    sqids = Sqids.new

    expect(sqids.decode('sexy')).to eq([200_044])
    expect(sqids.encode([200_044])).to eq('d171vI')
  end

  it 'does not use any blocklist if an empty blocklist is provided' do
    sqids = Sqids.new(blocklist: Set.new([]))

    expect(sqids.decode('sexy')).to eq([200_044])
    expect(sqids.encode([200_044])).to eq('sexy')
  end

  it 'uses provided blocklist if non-empty blocklist is provided' do
    sqids = Sqids.new(blocklist: Set.new(['AvTg']))

    expect(sqids.decode('sexy')).to eq([200_044])
    expect(sqids.encode([200_044])).to eq('sexy')

    expect(sqids.decode('AvTg')).to eq([100_000])
    expect(sqids.encode([100_000])).to eq('7T1X8k')
    expect(sqids.decode('7T1X8k')).to eq([100_000])
  end

  it 'uses blocklist to prevent certain encodings' do
    sqids = Sqids.new(blocklist: Set.new(%w[8QRLaD 7T1cd0dL UeIe imhw LfUQ]))

    expect(sqids.encode([1, 2, 3])).to eq('TM0x1Mxz')
    expect(sqids.decode('TM0x1Mxz')).to eq([1, 2, 3])
  end

  it 'can decode blocklist words' do
    sqids = Sqids.new(blocklist: Set.new(%w[8QRLaD 7T1cd0dL RA8UeIe7 WM3Limhw LfUQh4HN]))

    expect(sqids.decode('8QRLaD')).to eq([1, 2, 3])
    expect(sqids.decode('7T1cd0dL')).to eq([1, 2, 3])
    expect(sqids.decode('RA8UeIe7')).to eq([1, 2, 3])
    expect(sqids.decode('WM3Limhw')).to eq([1, 2, 3])
    expect(sqids.decode('LfUQh4HN')).to eq([1, 2, 3])
  end

  it 'matches against a short blocklist word' do
    sqids = Sqids.new(blocklist: Set.new(['pPQ']))

    expect(sqids.decode(sqids.encode([1_000]))).to eq([1_000])
  end

  it 'blocklist filtering in constructor' do
    # lowercase blocklist in only-uppercase alphabet
    sqids = Sqids.new(alphabet: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', blocklist: Set.new(['sqnmpn']))

    id = sqids.encode([1, 2, 3])
    numbers = sqids.decode(id)

    expect(id).to eq('ULPBZGBM') # without blocklist, would've been "SQNMPN"
    expect(numbers).to eq([1, 2, 3])
  end
end
