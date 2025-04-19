# CHANGELOG

**v0.2.2:**
- Improvement: Encoding floats creates large encoded string: [[PR #7](https://github.com/sqids/sqids-ruby/pull/8)] (thanks to [@akeenl-sp](https://github.com/akeenl-sp))

**v0.2.1:**
- Improvement: speeding up Sqids.new: [[PR #7](https://github.com/sqids/sqids-ruby/pull/7)] (thanks to [@lawrencegripper](https://github.com/lawrencegripper))

**v0.2.0:** **⚠️ BREAKING CHANGE**
- **Breaking change**: IDs change. Algorithm has been fine-tuned for better performance [[Issue #11](https://github.com/sqids/sqids-spec/issues/11)]
- `alphabet` cannot contain multibyte characters
- `min_length` upper limit has increased from alphabet length to `255`
- Max blocklist re-encoding attempts has been capped at the length of the alphabet - 1
- Minimum alphabet length has changed from 5 to 3
- `min_value()` and `max_value()` functions have been removed

**v0.1.2:**
- Bug fix: spec update (PR #7): blocklist filtering in uppercase-only alphabet [[PR #7](https://github.com/sqids/sqids-spec/pull/7)]
- Lower uniques test from 1_000_000 to 10_000

**v0.1.1:**
- Lowering Ruby version requirement to 3.0

**v0.1.0:**
- First implementation of [the spec](https://github.com/sqids/sqids-spec)