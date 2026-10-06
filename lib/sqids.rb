# frozen_string_literal: true

require 'set'

class Sqids
  DEFAULT_ALPHABET = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
  DEFAULT_MIN_LENGTH = 0
  # rubocop:disable Metrics/CollectionLiteralLength, Layout/LineLength
  DEFAULT_BLOCKLIST = %w[0rgasm 1d10t 1d1ot 1di0t 1diot 1eccacu10 1eccacu1o 1eccacul0
                         1eccaculo 1mbec11e 1mbec1le 1mbeci1e 1mbecile a11upat0 a11upato a1lupat0 a1lupato aand ah01e ah0le aho1e ahole al1upat0 al1upato allupat0 allupato ana1 ana1e anal anale anus arrapat0 arrapato arsch arse ass b00b b00be b01ata b0ceta b0iata b0ob b0obe b0sta b1tch b1te b1tte ba1atkar balatkar bastard0 bastardo batt0na battona bitch bite bitte bo0b bo0be bo1ata boceta boiata boob boobe bosta bran1age bran1er bran1ette bran1eur bran1euse branlage branler branlette branleur branleuse c0ck c0g110ne c0g11one c0g1i0ne c0g1ione c0gl10ne c0gl1one c0gli0ne c0glione c0na c0nnard c0nnasse c0nne c0u111es c0u11les c0u1l1es c0u1lles c0ui11es c0ui1les c0uil1es c0uilles c11t c11t0 c11to c1it c1it0 c1ito cabr0n cabra0 cabrao cabron caca cacca cacete cagante cagar cagare cagna cara1h0 cara1ho caracu10 caracu1o caracul0 caraculo caralh0 caralho cazz0 cazz1mma cazzata cazzimma cazzo ch00t1a ch00t1ya ch00tia ch00tiya ch0d ch0ot1a ch0ot1ya ch0otia ch0otiya ch1asse ch1avata ch1er ch1ng0 ch1ngadaz0s ch1ngadazos ch1ngader1ta ch1ngaderita ch1ngar ch1ngo ch1ngues ch1nk chatte chiasse chiavata chier ching0 chingadaz0s chingadazos chingader1ta chingaderita chingar chingo chingues chink cho0t1a cho0t1ya cho0tia cho0tiya chod choot1a choot1ya chootia chootiya cl1t cl1t0 cl1to clit clit0 clito cock cog110ne cog11one cog1i0ne cog1ione cogl10ne cogl1one cogli0ne coglione cona connard connasse conne cou111es cou11les cou1l1es cou1lles coui11es coui1les couil1es couilles cracker crap cu10 cu1att0ne cu1attone cu1er0 cu1ero cu1o cul0 culatt0ne culattone culer0 culero culo cum cunt d11d0 d11do d1ck d1ld0 d1ldo damn de1ch deich depp di1d0 di1do dick dild0 dildo dyke encu1e encule enema enf01re enf0ire enfo1re enfoire estup1d0 estup1do estupid0 estupido etr0n etron f0da f0der f0ttere f0tters1 f0ttersi f0tze f0utre f1ca f1cker f1ga fag fica ficker figa foda foder fottere fotters1 fottersi fotze foutre fr0c10 fr0c1o fr0ci0 fr0cio fr0sc10 fr0sc1o fr0sci0 fr0scio froc10 froc1o froci0 frocio frosc10 frosc1o frosci0 froscio fuck g00 g0o g0u1ne g0uine gandu go0 goo gou1ne gouine gr0gnasse grognasse haram1 harami haramzade hund1n hundin id10t id1ot idi0t idiot imbec11e imbec1le imbeci1e imbecile j1zz jerk jizz k1ke kam1ne kamine kike leccacu10 leccacu1o leccacul0 leccaculo m1erda m1gn0tta m1gnotta m1nch1a m1nchia m1st mam0n mamahuev0 mamahuevo mamon masturbat10n masturbat1on masturbate masturbati0n masturbation merd0s0 merd0so merda merde merdos0 merdoso mierda mign0tta mignotta minch1a minchia mist musch1 muschi n1gger neger negr0 negre negro nerch1a nerchia nigger orgasm p00p p011a p01la p0l1a p0lla p0mp1n0 p0mp1no p0mpin0 p0mpino p0op p0rca p0rn p0rra p0uff1asse p0uffiasse p1p1 p1pi p1r1a p1rla p1sc10 p1sc1o p1sci0 p1scio p1sser pa11e pa1le pal1e palle pane1e1r0 pane1e1ro pane1eir0 pane1eiro panele1r0 panele1ro paneleir0 paneleiro patakha pec0r1na pec0rina pecor1na pecorina pen1s pendej0 pendejo penis pip1 pipi pir1a pirla pisc10 pisc1o pisci0 piscio pisser po0p po11a po1la pol1a polla pomp1n0 pomp1no pompin0 pompino poop porca porn porra pouff1asse pouffiasse pr1ck prick pussy put1za puta puta1n putain pute putiza puttana queca r0mp1ba11e r0mp1ba1le r0mp1bal1e r0mp1balle r0mpiba11e r0mpiba1le r0mpibal1e r0mpiballe rand1 randi rape recch10ne recch1one recchi0ne recchione retard romp1ba11e romp1ba1le romp1bal1e romp1balle rompiba11e rompiba1le rompibal1e rompiballe ruff1an0 ruff1ano ruffian0 ruffiano s1ut sa10pe sa1aud sa1ope sacanagem sal0pe salaud salope saugnapf sb0rr0ne sb0rra sb0rrone sbattere sbatters1 sbattersi sborr0ne sborra sborrone sc0pare sc0pata sch1ampe sche1se sche1sse scheise scheisse schlampe schwachs1nn1g schwachs1nnig schwachsinn1g schwachsinnig schwanz scopare scopata sexy sh1t shit slut sp0mp1nare sp0mpinare spomp1nare spompinare str0nz0 str0nza str0nzo stronz0 stronza stronzo stup1d stupid succh1am1 succh1ami succhiam1 succhiami sucker t0pa tapette test1c1e test1cle testic1e testicle tette topa tr01a tr0ia tr0mbare tr1ng1er tr1ngler tring1er tringler tro1a troia trombare turd twat vaffancu10 vaffancu1o vaffancul0 vaffanculo vag1na vagina verdammt verga w1chsen wank wichsen x0ch0ta x0chota xana xoch0ta xochota z0cc01a z0cc0la z0cco1a z0ccola z1z1 z1zi ziz1 zizi zocc01a zocc0la zocco1a zoccola].freeze
  # rubocop:enable Metrics/CollectionLiteralLength, Layout/LineLength

  # Factor shared prefixes so long IDs do not scan hundreds of alternatives
  # at every character. All blocklist entries are literal strings.
  def self.pattern_source(words)
    # Very long custom words need no recursive factoring.
    return Regexp.union(words).source if words.any? { |word| word.length > 128 }

    groups = words.group_by { |word| word[0] }
    terminal = groups.delete(nil)
    branches = groups.map do |char, entries|
      Regexp.escape(char) + pattern_source(entries.map { |word| word[1..-1] })
    end
    return '' if branches.empty?

    source = branches.length == 1 ? branches[0] : "(?:#{branches.join('|')})"
    terminal ? "(?:#{source})?" : source
  end
  private_class_method :pattern_source

  def self.blocklist_patterns(blocklist)
    short, long = blocklist.partition { |word| word.length <= 3 }
    edges, anywhere = long.partition { |word| word.match?(/\d/) }
    [
      short.to_set.freeze,
      edges.empty? ? nil : Regexp.new("\\A#{pattern_source(edges)}").freeze,
      edges.empty? ? nil : Regexp.new("\\A#{pattern_source(edges.map(&:reverse))}").freeze,
      anywhere.empty? ? nil : Regexp.new(pattern_source(anywhere)).freeze
    ].freeze
  end
  private_class_method :blocklist_patterns

  # Custom lists are indexed in linear space instead of compiling a new
  # regexp tree. Encoding checks only substrings whose lengths occur in the
  # list; construction never expands every word into per-character objects.
  def self.blocklist_index(blocklist)
    return EMPTY_BLOCKLIST_INDEX if blocklist.empty?

    short = Set.new
    edges = {}
    anywhere = {}
    blocklist.each do |word|
      length = word.length
      if length <= 3
        short.add(word)
      else
        groups = word.match?(/\d/) ? edges : anywhere
        (groups[length] ||= Set.new).add(word)
      end
    end
    [short.freeze, edges.sort.map { |length, words| [length, words.freeze].freeze }.freeze,
     anywhere.sort.map { |length, words| [length, words.freeze].freeze }.freeze].freeze
  end
  private_class_method :blocklist_index

  DEFAULT_BLOCKLIST_PATTERNS = blocklist_patterns(DEFAULT_BLOCKLIST)
  DEFAULT_BLOCKLIST_FOUR = DEFAULT_BLOCKLIST.select { |word| word.length == 4 }.to_set.freeze
  DEFAULT_BLOCKLIST_FIVE = DEFAULT_BLOCKLIST.select { |word| word.length == 5 }.to_set.freeze
  DEFAULT_BLOCKLIST_INDEX_LIMIT = 12
  # Any long word can match an edge; only digit-free words can match
  # strictly inside an ID. Keep edge and interior checks disjoint.
  DEFAULT_BLOCKLIST_EDGES = begin
    groups = Array.new(DEFAULT_BLOCKLIST_INDEX_LIMIT + 1)
    groups[4] = DEFAULT_BLOCKLIST_FOUR
    groups[5] = DEFAULT_BLOCKLIST_FIVE
    DEFAULT_BLOCKLIST.each do |word|
      length = word.length
      next if length <= 5 || length > DEFAULT_BLOCKLIST_INDEX_LIMIT

      (groups[length] ||= Set.new).add(word)
    end
    groups.each { |words| words.freeze if words }
    groups.freeze
  end
  DEFAULT_BLOCKLIST_INTERIORS = DEFAULT_BLOCKLIST.select do |word|
    word.length >= 4 && word.length <= DEFAULT_BLOCKLIST_INDEX_LIMIT - 2 && !word.match?(/\d/)
  end.group_by(&:length).sort.map do |length, words|
    [length, words.to_set.freeze].freeze
  end.freeze
  EMPTY_BLOCKLIST_INDEX = [Set.new.freeze, [].freeze, [].freeze].freeze
  private_constant :DEFAULT_BLOCKLIST_PATTERNS, :DEFAULT_BLOCKLIST_FOUR, :DEFAULT_BLOCKLIST_FIVE,
                   :DEFAULT_BLOCKLIST_INDEX_LIMIT, :DEFAULT_BLOCKLIST_EDGES,
                   :DEFAULT_BLOCKLIST_INTERIORS, :EMPTY_BLOCKLIST_INDEX

  def initialize(options = {})
    alphabet = options[:alphabet] || DEFAULT_ALPHABET
    min_length = options[:min_length] || DEFAULT_MIN_LENGTH
    blocklist = options[:blocklist] || DEFAULT_BLOCKLIST

    raise ArgumentError, 'Alphabet cannot contain multibyte characters' if contains_multibyte_chars(alphabet)
    raise ArgumentError, 'Alphabet length must be at least 3' if alphabet.length < 3

    if alphabet.chars.uniq.size != alphabet.length
      raise ArgumentError,
            'Alphabet must contain unique characters'
    end

    min_length_limit = 255
    unless min_length.is_a?(Integer) && min_length >= 0 && min_length <= min_length_limit
      raise TypeError,
            "Minimum length has to be between 0 and #{min_length_limit}"
    end

    default_blocklist = blocklist == DEFAULT_BLOCKLIST && alphabet == DEFAULT_ALPHABET
    filtered_blocklist = if default_blocklist
                           DEFAULT_BLOCKLIST
                         elsif blocklist.empty?
                           blocklist
                         else
                           downcased_alphabet = alphabet.downcase
                           # A character class avoids allocating an array and a
                           # string for every character of every candidate word.
                           if downcased_alphabet.ascii_only?
                             allowed = Regexp.new("\\A[#{Regexp.escape(downcased_alphabet)}]*\\z")
                             blocklist.each_with_object(Set.new) do |word, filtered|
                               next if word.length < 3

                               normalized = word.downcase
                               filtered.add(normalized) if normalized.encoding.ascii_compatible? && allowed.match?(normalized)
                             end
                           else
                             chars = downcased_alphabet.chars
                             blocklist.select do |word|
                               word.length >= 3 && (word.downcase.chars - chars).empty?
                             end.to_set(&:downcase)
                           end
                         end

    @alphabet = shuffle(alphabet)
    @min_length = min_length
    if default_blocklist
      @blocklist_patterns = DEFAULT_BLOCKLIST_PATTERNS
    else
      @blocklist_index = self.class.send(:blocklist_index, filtered_blocklist)
    end
    @alphabet_bytes = @alphabet.bytes.freeze
    # A sparse map avoids a 2 KiB table for a three-character alphabet.
    @alphabet_positions = @alphabet_bytes.length < 16 ? {} : Array.new(256)
    @alphabet_bytes.each_with_index { |byte, index| @alphabet_positions[byte] = index }
    @alphabet_positions.freeze
  end

  def encode(numbers)
    return '' if numbers.empty?

    in_range_numbers = numbers.map(&:to_i).select { |n| n >= 0 && n <= Sqids.max_value }
    unless in_range_numbers.length == numbers.length
      raise ArgumentError,
            "Encoding supports numbers between 0 and #{Sqids.max_value}"
    end

    encode_numbers(in_range_numbers)
  end

  def decode(id)
    ret = []

    return ret if id.empty?

    id.each_byte do |byte|
      return ret unless @alphabet_positions[byte]
    end
    # Alphabet characters are single bytes, so a multibyte input is invalid
    # even when its individual bytes happen to belong to the alphabet.
    return ret if contains_multibyte_chars(id)

    offset = @alphabet_positions[id.getbyte(0)]
    alphabet = @alphabet_bytes.rotate(offset).reverse!

    id = id[1, id.length]

    while id.length.positive?
      separator = alphabet[0].chr(@alphabet.encoding)

      chunks = id.split(separator, 2)
      if chunks.any?
        return ret if chunks[0] == ''

        ret.push(to_number(chunks[0], alphabet))
        shuffle_bytes!(alphabet) if chunks.length > 1
      end

      id = chunks.length > 1 ? chunks[1] : ''
    end

    ret
  end

  private

  def shuffle(alphabet)
    shuffle_bytes!(alphabet.bytes).pack('C*').force_encoding(alphabet.encoding)
  end

  def shuffle_bytes!(bytes)
    length = bytes.length
    i = 0
    j = length - 1
    while j.positive?
      r = ((i * j) + bytes[i] + bytes[j]) % length
      temporary = bytes[i]
      bytes[i] = bytes[r]
      bytes[r] = temporary
      i += 1
      j -= 1
    end
    bytes
  end

  def encode_numbers(numbers, increment: 0)
    length = @alphabet_bytes.length
    raise ArgumentError, 'Reached max attempts to re-generate the ID' if increment > length

    offset = numbers.length
    numbers.each_with_index { |v, i| offset += @alphabet_bytes[v % length] + i }
    offset = (offset + increment) % length

    alphabet = @alphabet_bytes.rotate(offset)
    id = [alphabet[0]]
    alphabet.reverse!
    base = length - 1

    numbers.each_with_index do |num, i|
      digits = []
      begin
        digits << alphabet[1 + num % base]
        num /= base
      end while num.positive?
      id.concat(digits.reverse!)

      next unless i < numbers.length - 1

      id << alphabet[0]
      shuffle_bytes!(alphabet)
    end

    if @min_length > id.length
      id << alphabet[0]
      while @min_length > id.length
        shuffle_bytes!(alphabet)
        id.concat(alphabet.take([@min_length - id.length, length].min))
      end
    end

    result = id.pack('C*').force_encoding(@alphabet.encoding)
    return encode_numbers(numbers, increment: increment + 1) if blocked_id?(result)

    result
  end

  def to_number(id, alphabet)
    base = alphabet.length - 1
    number = 0
    id.each_byte { |byte| number = (number * base) + alphabet.index(byte) - 1 }
    number
  end

  def blocked_id?(id)
    return blocked_by_index?(id.downcase) if @blocklist_index

    short, prefix, suffix, anywhere = @blocklist_patterns
    return short.include?(id.downcase) if id.length <= 3

    id = id.downcase
    length = id.length
    if length > DEFAULT_BLOCKLIST_INDEX_LIMIT
      return (prefix && prefix.match?(id)) || (suffix && suffix.match?(id.reverse)) ||
             (anywhere && anywhere.match?(id))
    end

    return DEFAULT_BLOCKLIST_FOUR.include?(id) if length == 4

    # At five characters, every four-character substring is an edge match.
    if length == 5
      return DEFAULT_BLOCKLIST_FIVE.include?(id) ||
             DEFAULT_BLOCKLIST_FOUR.include?(id[0, 4]) || DEFAULT_BLOCKLIST_FOUR.include?(id[1, 4])
    end

    blocked_by_default_index?(id, length)
  end

  def blocked_by_default_index?(id, length)
    whole = DEFAULT_BLOCKLIST_EDGES[length]
    return true if whole && whole.include?(id)

    word_length = 4
    while word_length < length
      words = DEFAULT_BLOCKLIST_EDGES[word_length]
      if words && (words.include?(id.byteslice(0, word_length)) ||
                   words.include?(id.byteslice(-word_length, word_length)))
        return true
      end
      word_length += 1
    end

    DEFAULT_BLOCKLIST_INTERIORS.each do |interior_length, words|
      break if interior_length > length - 2

      offset = 1
      limit = length - interior_length - 1
      while offset <= limit
        return true if words.include?(id.byteslice(offset, interior_length))

        offset += 1
      end
    end
    false
  end

  def blocked_by_index?(id)
    short, edges, anywhere = @blocklist_index
    return short.include?(id) if id.length <= 3

    length = id.length
    edges.each do |word_length, words|
      break if word_length > length
      return true if words.include?(id[0, word_length]) || words.include?(id[-word_length, word_length])
    end
    anywhere.each do |word_length, words|
      break if word_length > length

      offset = 0
      limit = length - word_length
      while offset <= limit
        return true if words.include?(id.byteslice(offset, word_length))

        offset += 1
      end
    end
    false
  end

  def contains_multibyte_chars(input_str)
    input_str.bytesize != input_str.length
  end

  def self.max_value
    defined?(Integer::MAX) ? Integer::MAX : ((2**((0.size * 8) - 2)) - 1)
  end
end
