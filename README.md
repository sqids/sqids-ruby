# [Sqids Ruby](https://sqids.org/ruby)

[![Github Actions](https://img.shields.io/github/actions/workflow/status/sqids/sqids-ruby/tests.yml)](https://github.com/sqids/sqids-ruby/actions)

Sqids (pronounced "squids") is a small library that lets you generate YouTube-looking IDs from numbers. It's good for link shortening, fast & URL-safe ID generation and decoding back into numbers for quicker database lookups.

## Getting started

Add this line to your application's Gemfile:

```ruby
gem 'sqids'
```

And then execute:

```bash
bundle
```

Or install it via:

```bash
gem install sqids
```

## Examples

Simple encode & decode:

```ruby
sqids = Sqids.new
id = sqids.encode([1, 2, 3]) # '8QRLaD'
numbers = sqids.decode(id) # [1, 2, 3]
```

Randomize IDs by providing a custom alphabet:

```ruby
sqids = Sqids.new(alphabet: 'FxnXM1kBN6cuhsAvjW3Co7l2RePyY8DwaU04Tzt9fHQrqSVKdpimLGIJOgb5ZE')
id = sqids.encode([1, 2, 3]) # 'B5aMa3'
numbers = sqids.decode(id) # [1, 2, 3]
```

Enforce a *minimum* length for IDs:

```ruby
sqids = Sqids.new(min_length: 10)
id = sqids.encode([1, 2, 3]) # '75JT1cd0dL'
numbers = sqids.decode(id) # [1, 2, 3]
```

Prevent specific words from appearing anywhere in the auto-generated IDs:

```ruby
sqids = Sqids.new(blocklist: Set.new(%w[word1 word2]))
id = sqids.encode([1, 2, 3]) # '8QRLaD'
numbers = sqids.decode(id) # [1, 2, 3]
```

## License

[MIT](LICENSE)
