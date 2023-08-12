require 'json'

class Sqids
  DEFAULT_ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  DEFAULT_MIN_LENGTH = 0
  DEFAULT_BLOCKLIST = JSON.parse(File.read('lib/blocklist.json'))

  def initialize(options = {})
    alphabet = options[:alphabet] || DEFAULT_ALPHABET
    min_length = options[:min_length] || DEFAULT_MIN_LENGTH
    blocklist = options[:blocklist] || DEFAULT_BLOCKLIST

    raise ArgumentError, 'Alphabet length must be at least 5' if alphabet.length < 5

    if alphabet.chars.uniq.size != alphabet.length
      raise ArgumentError,
            'Alphabet must contain unique characters'
    end

    unless min_length.is_a?(Integer) && min_length >= Sqids.min_value && min_length <= alphabet.length
      raise TypeError,
            "Minimum length has to be between #{Sqids.min_value} and #{alphabet.length}"
    end

    filtered_blocklist = blocklist.select do |word|
      word.length >= 3 && (word.chars - alphabet.chars).empty?
    end.map(&:downcase).to_set

    @alphabet = shuffle(alphabet)
    @min_length = min_length
    @blocklist = filtered_blocklist
  end

  def encode(numbers)
    return '' if numbers.empty?

    in_range_numbers = numbers.select { |n| n >= Sqids.min_value && n <= Sqids.max_value }
    unless in_range_numbers.length == numbers.length
      raise ArgumentError,
            "Encoding supports numbers between #{Sqids.min_value} and #{Sqids.max_value}"
    end

    encode_numbers(in_range_numbers, false)
  end

  def decode(id)
    ret = []

    return ret if id.empty?

    alphabet_chars = @alphabet.chars
    id.chars.each do |c|
      return ret unless alphabet_chars.include?(c)
    end

    prefix = id[0]
    offset = @alphabet.index(prefix)
    alphabet = @alphabet.slice(offset, @alphabet.length) + @alphabet.slice(0, offset)
    partition = alphabet[1]
    alphabet = alphabet.slice(2, alphabet.length)

    id = id[1, id.length]

    partition_index = id.index(partition)
    if !partition_index.nil? && partition_index.positive? && partition_index < id.length - 1
      id = id[partition_index + 1, id.length]
      alphabet = shuffle(alphabet)
    end

    while id.length > 0
      separator = alphabet[-1]
      chunks = id.split(separator, 2)

      if chunks.any?
        alphabet_without_separator = alphabet.slice(0, alphabet.length - 1)
        return [] unless chunks[0].chars.all? { |c| alphabet_without_separator.include?(c) }

        ret.push(to_number(chunks[0], alphabet_without_separator))
        alphabet = shuffle(alphabet) if chunks.length > 1
      end

      id = chunks.length > 1 ? chunks[1] : ''
    end

    ret
  end

  def self.min_value
    0
  end

  def self.max_value
    defined?(Integer::MAX) ? Integer::MAX : (2**(0.size * 8 - 2) - 1)
  end

  private

  def shuffle(alphabet)
    chars = alphabet.chars

    i = 0
    j = chars.length - 1
    while j > 0
      r = (i * j + chars[i].ord + chars[j].ord) % chars.length
      chars[i], chars[r] = chars[r], chars[i]
      i += 1
      j -= 1
    end

    chars.join('')
  end

  def encode_numbers(numbers, partitioned = false)
    offset = numbers.length
    numbers.each_with_index do |v, i|
      offset += @alphabet[v % @alphabet.length].ord + i
    end
    offset = offset % @alphabet.length

    alphabet = @alphabet.slice(offset, @alphabet.length) + @alphabet.slice(0, offset)
    prefix = alphabet[0]
    partition = alphabet[1]
    alphabet = alphabet.slice(2, alphabet.length)
    ret = [prefix]

    numbers.each_with_index do |num, i|
      alphabet_without_separator = alphabet.slice(0, alphabet.length - 1)
      ret.push(to_id(num, alphabet_without_separator))

      next unless i < numbers.length - 1

      separator = alphabet[-1]
      if partitioned && i.zero?
        ret.push(partition)
      else
        ret.push(separator)
      end

      alphabet = shuffle(alphabet)
    end

    id = ret.join('')

    if @min_length > id.length
      unless partitioned
        numbers = [0] + numbers
        id = encode_numbers(numbers, true)
      end

      if @min_length > id.length
        id = id[0] + alphabet[0,
                              @min_length - id.length] + id[1,
                                                            id.length - 1]
      end
    end

    if blocked_id?(id)
      if partitioned
        numbers[0] += 1
      else
        numbers = [0] + numbers
      end

      id = encode_numbers(numbers, true)
    end

    id
  end

  def to_id(num, alphabet)
    id = []
    chars = alphabet.chars

    result = num
    loop do
      id.unshift(chars[result % chars.length])
      result /= chars.length
      break unless result.positive?
    end

    id.join('')
  end

  def to_number(id, alphabet)
    chars = alphabet.chars
    id.chars.reduce(0) { |a, v| a * chars.length + chars.index(v) }
  end

  def blocked_id?(id)
    id = id.downcase

    @blocklist.any? do |word|
      if word.length <= id.length
        if id.length <= 3 || word.length <= 3
          id == word
        elsif word.match?(/\d/)
          id.start_with?(word) || id.end_with?(word)
        else
          id.include?(word)
        end
      end
    end
  end
end
