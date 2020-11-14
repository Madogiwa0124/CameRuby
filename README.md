# 🐫CameRuby💎

⚠ This is a hoby repository Do not use in production.

camelCase🐫 + Ruby💎 = 🐫CameRuby💎.

I experimented if I could write in camelCase🐫 by converting from camelCase🐫 to snake_case🐍.

## Usage

### Use implementation using `method_missing`

``` ruby
require_relative './lib/cameRuby/methodMissing'
class Object
  include CameRuby::MethodMissing
end

puts 'foo'.respondTo?(:toS, false)
#=> true
puts 'foo'.toS
#=> foo
puts String.respondTo?(:tryConvert, false)
#=> true
puts String.tryConvert('str')
#=> str

class Book
  def initialize(name, publishedAt)
    @name = name
    @publishedAt = publishedAt
  end

  attr_reader :name, :publishedAt
end

book = Book.new('foo', Time.now)
p book.name
#=> "foo"
p book.publishedAt.toS
#=> "2020-11-14 14:23:24 +0900"
```

### Use implementation using `alias_method`

``` ruby
require_relative './lib/cameRuby/aliasMethod'
CameRuby::AliasMethod.call

puts 'foo'.respondTo?(:toS, false)
#=> true
puts 'foo'.toS
#=> foo
puts String.respondTo?(:tryConvert, false)
#=> true
puts String.tryConvert('str')
#=> str

class Book
  def initialize(name, publishedAt)
    @name = name
    @publishedAt = publishedAt
  end

  attr_reader :name, :publishedAt
end

book = Book.new('foo', Time.now)
p book.name
#=> "foo"
p book.publishedAt.toS
#=> "2020-11-14 14:23:24 +0900"
```

## Benchmark

### Implementation using `method_missing`

very slow because it uses `method_missing`...

``` ruby
require_relative './lib/cameRuby/methodMissing'
class Object
  include CameRuby::MethodMissing
end

n = 100000
Benchmark.bm(7, ">total:", ">avg:") do |x|
  x.report("to_s:") { "foo".to_s }
  x.report("toS:") { "foo".toS }
end

              user     system      total        real
to_s:     0.000006   0.000005   0.000011 (  0.000007)
toS:      0.000188   0.000009   0.000197 (  0.000197)
```

### Implementation using `alias_method`

Surprisingly fast, but it takes time to predefine alias_method...

``` ruby
require_relative './lib/cameRuby/aliasMethod'
CameRuby::AliasMethod.call

n = 100000
Benchmark.bm(7, ">total:", ">avg:") do |x|
  x.report("to_s:") { "foo".to_s }
  x.report("toS:") { "foo".toS }
end

              user     system      total        real
to_s:     0.000009   0.000006   0.000015 (  0.000008)
toS:      0.000003   0.000001   0.000004 (  0.000002)
```
