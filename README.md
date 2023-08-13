# [Sqids Ruby](https://sqids.org/ruby)

[![Gem Version](https://badge.fury.io/rb/sqids.svg)](https://rubygems.org/gems/sqids)
[![Github Actions](https://img.shields.io/github/actions/workflow/status/sqids/sqids-ruby/tests.yml)](https://github.com/sqids/sqids-ruby/actions)
[![Downloads](https://img.shields.io/gem/dt/sqids)](https://crates.io/crates/sqids)

[Sqids](https://sqids.org/ruby) (*pronounced "squids"*) is a small library that lets you **generate unique IDs from numbers**. It's good for link shortening, fast & URL-safe ID generation and decoding back into numbers for quicker database lookups.

Features:

- **Encode multiple numbers** - generate short IDs from one or several non-negative numbers
- **Quick decoding** - easily decode IDs back into numbers
- **Unique IDs** - generate unique IDs by shuffling the alphabet once
- **ID padding** - provide minimum length to make IDs more uniform
- **URL safe** - auto-generated IDs do not contain common profanity
- **Randomized output** - Sequential input provides nonconsecutive IDs
- **Many implementations** - Support for [40+ programming languages](https://sqids.org/)

## 🧰 Use-cases

Good for:

- Generating IDs for public URLs (eg: link shortening)
- Generating IDs for internal systems (eg: event tracking)
- Decoding for quicker database lookups (eg: by primary keys)

Not good for:

- Sensitive data (this is not an encryption library)
- User IDs (can be decoded revealing user count)

## 🚀 Getting started

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

## 👩‍💻 Examples

Simple encode & decode:

```ruby
sqids = Sqids.new
id = sqids.encode([1, 2, 3]) # '8QRLaD'
numbers = sqids.decode(id) # [1, 2, 3]
```

> **Note**
> 🚧 Because of the algorithm's design, **multiple IDs can decode back into the same sequence of numbers**. If it's important to your design that IDs are canonical, you have to manually re-encode decoded numbers and check that the generated ID matches.

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

## 📝 License

[MIT](LICENSE)
