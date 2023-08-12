# frozen_string_literal: true

require 'rspec'
require_relative '../lib/sqids'

describe Sqids do
  let(:default_alphabet) { Sqids::DEFAULT_ALPHABET }

  it 'encodes and decodes simple numbers' do
    sqids = Sqids.new(min_length: default_alphabet.length)

    numbers = [1, 2, 3]
    id = '75JILToVsGerOADWmHlY38xvbaNZKQ9wdFS0B6kcMEtnRpgizhjU42qT1cd0dL'

    expect(sqids.encode(numbers)).to eq(id)
    expect(sqids.decode(id)).to eq(numbers)
  end

  it 'encodes and decodes incremental numbers' do
    sqids = Sqids.new(min_length: default_alphabet.length)

    ids = {
      'jf26PLNeO5WbJDUV7FmMtlGXps3CoqkHnZ8cYd19yIiTAQuvKSExzhrRghBlwf' => [0, 0],
      'vQLUq7zWXC6k9cNOtgJ2ZK8rbxuipBFAS10yTdYeRa3ojHwGnmMV4PDhESI2jL' => [0, 1],
      'YhcpVK3COXbifmnZoLuxWgBQwtjsSaDGAdr0ReTHM16yI9vU8JNzlFq5Eu2oPp' => [0, 2],
      'OTkn9daFgDZX6LbmfxI83RSKetJu0APihlsrYoz5pvQw7GyWHEUcN2jBqd4kJ9' => [0, 3],
      'h2cV5eLNYj1x4ToZpfM90UlgHBOKikQFvnW36AC8zrmuJ7XdRytIGPawqYEbBe' => [0, 4],
      '7Mf0HeUNkpsZOTvmcj836P9EWKaACBubInFJtwXR2DSzgYGhQV5i4lLxoT1qdU' => [0, 5],
      'APVSD1ZIY4WGBK75xktMfTev8qsCJw6oyH2j3OnLcXRlhziUmpbuNEar05QCsI' => [0, 6],
      'P0LUhnlT76rsWSofOeyRGQZv1cC5qu3dtaJYNEXwk8Vpx92bKiHIz4MgmiDOF7' => [0, 7],
      'xAhypZMXYIGCL4uW0te6lsFHaPc3SiD1TBgw5O7bvodzjqUn89JQRfk2Nvm4JI' => [0, 8],
      '94dRPIZ6irlXWvTbKywFuAhBoECQOVMjDJp53s2xeqaSzHY8nc17tmkLGwfGNl' => [0, 9]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'encodes with different min lengths' do
    [0, 1, 5, 10, default_alphabet.length].each do |min_length|
      [
        [Sqids.min_value],
        [0, 0, 0, 0, 0],
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        [100, 200, 300],
        [1_000, 2_000, 3_000],
        [1_000_000],
        [Sqids.max_value]
      ].each do |numbers|
        sqids = Sqids.new(min_length:)

        id = sqids.encode(numbers)
        expect(id.length).to be >= min_length
        expect(sqids.decode(id)).to eq(numbers)
      end
    end
  end

  it 'raises error for out-of-range invalid min lengths' do
    expect { Sqids.new(min_length: -1) }.to raise_error(TypeError)
    expect { Sqids.new(min_length: default_alphabet.length + 1) }.to raise_error(TypeError)
  end
end
