# frozen_string_literal: true

require 'rspec'
require_relative '../lib/sqids'

describe Sqids do
  let(:default_alphabet) { Sqids::DEFAULT_ALPHABET }

  it 'encodes and decodes simple numbers' do
    sqids = Sqids.new(min_length: default_alphabet.length)

    numbers = [1, 2, 3]
    id = '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM'

    expect(sqids.encode(numbers)).to eq(id)
    expect(sqids.decode(id)).to eq(numbers)
  end

  it 'encodes and decodes incremental' do
    numbers = [1, 2, 3]
    map = {
      6 => '86Rf07',
      7 => '86Rf07x',
      8 => '86Rf07xd',
      9 => '86Rf07xd4',
      10 => '86Rf07xd4z',
      11 => '86Rf07xd4zB',
      12 => '86Rf07xd4zBm',
      13 => '86Rf07xd4zBmi'
    }
    map[default_alphabet.length + 0] = '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM'
    map[default_alphabet.length + 1] = '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMy'
    map[default_alphabet.length + 2] = '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf'
    map[default_alphabet.length + 3] = '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf1'

    map.each do |min_length, id|
      sqids = Sqids.new(min_length: min_length)

      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.encode(numbers).length).to eq(min_length)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'encodes and decodes incremental numbers' do
    sqids = Sqids.new(min_length: default_alphabet.length)

    ids = {
      'SvIzsqYMyQwI3GWgJAe17URxX8V924Co0DaTZLtFjHriEn5bPhcSkfmvOslpBu' => [0, 0],
      'n3qafPOLKdfHpuNw3M61r95svbeJGk7aAEgYn4WlSjXURmF8IDqZBy0CT2VxQc' => [0, 1],
      'tryFJbWcFMiYPg8sASm51uIV93GXTnvRzyfLleh06CpodJD42B7OraKtkQNxUZ' => [0, 2],
      'eg6ql0A3XmvPoCzMlB6DraNGcWSIy5VR8iYup2Qk4tjZFKe1hbwfgHdUTsnLqE' => [0, 3],
      'rSCFlp0rB2inEljaRdxKt7FkIbODSf8wYgTsZM1HL9JzN35cyoqueUvVWCm4hX' => [0, 4],
      'sR8xjC8WQkOwo74PnglH1YFdTI0eaf56RGVSitzbjuZ3shNUXBrqLxEJyAmKv2' => [0, 5],
      'uY2MYFqCLpgx5XQcjdtZK286AwWV7IBGEfuS9yTmbJvkzoUPeYRHr4iDs3naN0' => [0, 6],
      '74dID7X28VLQhBlnGmjZrec5wTA1fqpWtK4YkaoEIM9SRNiC3gUJH0OFvsPDdy' => [0, 7],
      '30WXpesPhgKiEI5RHTY7xbB1GnytJvXOl2p0AcUjdF6waZDo9Qk8VLzMuWrqCS' => [0, 8],
      'moxr3HqLAK0GsTND6jowfZz3SUx7cQ8aC54Pl1RbIvFXmEJuBMYVeW9yrdOtin' => [0, 9]
    }

    ids.each do |id, numbers|
      expect(sqids.encode(numbers)).to eq(id)
      expect(sqids.decode(id)).to eq(numbers)
    end
  end

  it 'encodes with different min lengths' do
    [0, 1, 5, 10, default_alphabet.length].each do |min_length|
      [
        [0],
        [0, 0, 0, 0, 0],
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        [100, 200, 300],
        [1_000, 2_000, 3_000],
        [1_000_000],
        [Sqids.max_value]
      ].each do |numbers|
        sqids = Sqids.new(min_length: min_length)

        id = sqids.encode(numbers)
        expect(id.length).to be >= min_length
        expect(sqids.decode(id)).to eq(numbers)
      end
    end
  end

  it 'raises error for out-of-range invalid min lengths' do
    expect { Sqids.new(min_length: -1) }.to raise_error(TypeError)
    expect { Sqids.new(min_length: 256) }.to raise_error(TypeError)
  end
end
